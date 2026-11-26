#!/usr/bin/env bash
# ─────────────────────────────────────────────
# Apps menu — installs the M-p menu from menu/*.sh
# One file per item: label = file name, hotkey = its first letter, item = a
# popup in the current pane's directory running that script. A new
# menu/<name>.sh shows up after a config reload (menu.conf runs this at load).
# ─────────────────────────────────────────────

set -euo pipefail

dir=$(cd "${0%/*}/.." && pwd)/menu   # absolute: shown in the menu command

args=(display-menu -T '#[align=centre] Apps ' -x C -y C)
keys=()
for f in "$dir"/*.sh; do
  [ -f "$f" ] || continue
  name=${f##*/}
  name=${name%.sh}
  key=${name:0:1}
  [[ " ${keys[*]-} q " == *" $key "* ]] && continue   # first file wins a taken key, q is quit
  keys+=("$key")
  args+=("$name" "$key" "display-popup -d '#{pane_current_path}' -w 90% -h 90% -E $f")
done
args+=("quit" q "")

tmux bind-key -n M-p "${args[@]}"
