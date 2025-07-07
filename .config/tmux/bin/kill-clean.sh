#!/usr/bin/env bash
# tmux-kill-clean
# Завершает все процессы nvim в tmux-сессии перед её удалением

set -e

# Проверка аргументов
if [ -z "$1" ]; then
  echo "Usage: tmux-kill-clean <session-name>"
  exit 1
fi

SESSION="$1"

# Проверяем, существует ли указанная сессия
if ! tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "Session '$SESSION' does not exist."
  exit 1
fi

echo "Closing Neovim instances in tmux session '$SESSION'..."

# Получаем все pane PIDs в сессии
PANES=$(tmux list-panes -t "$SESSION" -F "#{pane_pid}")

for PID in $PANES; do
  # Ищем дочерние процессы nvim каждого pane PID
  NVIMS=$(pgrep -P "$PID" nvim || true)
  for NPID in $NVIMS; do
    echo "Sending ':qa' to nvim process $NPID"
    # Проверяем, поддерживает ли процесс RPC
    if lsof -p "$NPID" | grep -q '/tmp/nvim'; then
      # Если у тебя настроено nvim --listen /tmp/nvim
      nvim --server /tmp/nvim --remote-send ":qa<CR>"
    else
      # Иначе шлём SIGTERM (мягкое завершение)
      kill -TERM "$NPID"
    fi
  done
done

# Ждём несколько секунд для graceful exit
sleep 1

echo "Killing tmux session '$SESSION'"
tmux kill-session -t "$SESSION"

echo "Done."
