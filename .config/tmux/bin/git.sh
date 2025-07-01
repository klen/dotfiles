#!/usr/bin/env bash

cd "${1:-$PWD}"

if git rev-parse --is-inside-work-tree &>/dev/null; then
  # Имя ветки
  branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

  # Проверяем локальные изменения
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    has_local_changes=1
    dirty=" *"
  else
    has_local_changes=0
    dirty=""
  fi

  # Проверяем отличия с origin
  git fetch --quiet origin &>/dev/null
  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

  if [[ -n "$upstream" ]]; then
    diff=$(git rev-list --left-right --count HEAD...${upstream} 2>/dev/null)
    left=${diff%%	*}
    right=${diff##*	}

    if [[ "$left" -ne 0 || "$right" -ne 0 ]]; then
      # Отличия с origin ➔ красный
      branch="#[fg=red,bold]${branch_name}"
    elif [[ "$has_local_changes" -eq 1 ]]; then
      # Локальные изменения, но без расхождений ➔ жёлтый
      branch="#[fg=yellow,bold]${branch_name}"
    else
      # Нет изменений и расхождений ➔ default (без цвета)
      branch="${branch_name}"
    fi
  else
    # Нет upstream ➔ серый
    branch="#[fg=grey,bold]${branch_name}"
  fi

  # Выводим
  echo "${branch}#[default]${dirty} | "
else
  echo ""
fi
