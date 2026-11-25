#!/usr/bin/env bash
# ─────────────────────────────────────────────
# Session switcher — pick a session with fzf, switch the calling client.
# `--check` exits 0 when fzf is new enough for the picker, so tmux can fall
# back to its own choose-tree instead. `--dirs` (bound to `s`) lists saved
# layouts from sessions/*.sh first, then zoxide directories.
# A layout is a plain bash file in sessions/. The picker creates the session and
# sources the file in its first window's shell (env s = session name), so its
# lines act like typed commands: cd sticks, tmux lines need -t "$s:". A directory
# pick uses <dir>/.tmux.sh, else sessions/<dirname>.sh, else sessions/_default.sh.
# Existing sessions are reused instead of rebuilt.
# ─────────────────────────────────────────────

set -euo pipefail

# --no-input / transform / show-input need fzf >= 0.57; distro packages are older
fzf_ok() {
  local v
  v=$(fzf --version 2>/dev/null) || return 1
  [[ $v =~ ^([0-9]+)\.([0-9]+) ]] && ((BASH_REMATCH[1] > 0 || BASH_REMATCH[2] >= 57))
}

[ "${1:-}" = "--check" ] && { fzf_ok; exit; }

if [ "${1:-}" = "--dirs" ]; then
  sessions=$(cd "${0%/*}/.." && pwd)/sessions   # absolute: layouts are sourced in a new pane
  sel=$(
    {
      for f in "$sessions"/*.sh; do
        n=${f##*/}
        [[ $n == _* ]] && continue     # _default is a fallback, not a choice
        [ -f "$f" ] && printf '%s\t%s\n' "${n%.sh}" "$f"
      done
      if command -v zoxide >/dev/null; then
        zoxide query -l | while IFS= read -r d; do printf '%s\t%s\n' "$d" "$d"; done
      fi
    } | FZF_DEFAULT_OPTS= fzf --layout=reverse-list --delimiter='\t' --with-nth 1 \
      --prompt='new › ' --header='enter start · esc quit' \
      --preview 'p=$(printf %s {} | cut -f2); [ -f "$p" ] && cat "$p" || ls -ap "$p"' \
      --preview-window='right:50%'
  ) || exit 0
  target=${sel#*$'\t'}
  [ -n "$target" ] || exit 0
  name=${target##*/}
  name=${name%.sh}
  name=${name//[.:]/_}       # dots and colons do not belong in session targets
  if [ -f "$target" ]; then
    layout=$target dir=$PWD
  else
    layout=$target/.tmux.sh                    # layout shipped with the project
    [ -f "$layout" ] || layout=$sessions/$name.sh
    [ -f "$layout" ] || layout=$sessions/_default.sh
    dir=$target
  fi
  if ! tmux has-session -t "=$name" 2>/dev/null; then
    tmux new-session -d -s "$name" -n "$name" -c "$dir" -e "s=$name"
    if [ -f "$layout" ]; then tmux send-keys -t "$name:" "source $layout" C-m; fi
  fi
  # A layout whose first pane dies (bad command, missing PATH) leaves no session.
  tmux has-session -t "=$name" 2>/dev/null || { tmux display-message "layout '$name' created no session"; exit 0; }
  tmux switch-client -t "=$name"
  exit
fi

current=$(tmux display-message -p '#{session_name}')

out=$(tmux list-sessions -F '#{session_name}' | FZF_DEFAULT_OPTS= fzf --layout=reverse-list --no-input --print-query --tiebreak=index \
  --bind 'start:disable-search,j:down,k:up,q:abort,i:enable-search+show-input+clear-query+unbind(j)+unbind(k)+unbind(d)+unbind(q)+unbind(i),esc:transform:[ "$FZF_INPUT_STATE" = hidden ] && echo abort || echo "disable-search+hide-input+rebind(j)+rebind(k)+rebind(d)+rebind(q)+rebind(i)"' \
  --bind "s:become($0 --dirs)" \
  --bind 'd:execute-silent(target={}; [ -n "$target" ] || exit 0; if [ "$target" = "'"$current"'" ]; then next=$(tmux list-sessions -F "#{session_name}" | grep -vxF "$target" | head -1); [ -n "$next" ] || exit 0; tmux switch-client -t "$next"; fi; tmux kill-session -t "$target")+reload(tmux list-sessions -F "#{session_name}")' \
  --prompt='session › ' --header="j/k move · i search/new · s layouts+dirs · d kill · q quit" \
  --preview 'tmux capture-pane -ep -t {} | tail -n ${FZF_PREVIEW_LINES:-30}' \
  --preview-window='right:50%') || [ $? = 1 ] || exit 0

session=$(printf '%s\n' "$out" | sed -n 2p)
query=$(printf '%s\n' "$out" | sed -n 1p)
[ -n "$session" ] || { [ -n "$query" ] || exit 0; session=$(tmux new-session -dP -F '#{session_name}' -s "$query"); }
tmux switch-client -t "$session"
