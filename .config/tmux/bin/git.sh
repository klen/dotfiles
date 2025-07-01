#!/usr/bin/env bash

cd "${1:-$PWD}"

if git rev-parse --is-inside-work-tree &>/dev/null; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

  # Цвет ветки (по желанию)
  branch="#[fg=green]${branch}#[default]"

  # Локальные изменения (жёлтый)
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty="#[fg=yellow]*#[default]"
  else
    dirty=""
  fi

  # Проверяем отличия с origin (красный)
  git fetch --quiet origin &>/dev/null
  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

  if [[ -n "$upstream" ]]; then
    diff=$(git rev-list --left-right --count HEAD...${upstream} 2>/dev/null)
    left=${diff%%	*}
    right=${diff##*	}

    if [[ "$left" -ne 0 || "$right" -ne 0 ]]; then
      diverged="#[fg=red][div]#[default]"
    else
      diverged=""
    fi
  else
    diverged=""
  fi

  echo "${branch}${dirty}${diverged} |"
else
  echo ""
fi
