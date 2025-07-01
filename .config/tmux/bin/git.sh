#!/usr/bin/env bash

cd "${1:-$PWD}"

if git rev-parse --is-inside-work-tree &>/dev/null; then
  # Определяем имя ветки
  branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

  # Проверяем локальные изменения
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    dirty=" *"
  else
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
      # отличается от origin ➔ красный
      branch="#[fg=red,bold]${branch_name}"
    else
      # совпадает с origin ➔ зелёный
      branch="#[fg=green,bold]${branch_name}"
    fi
  else
    # нет upstream ➔ серый
    branch="#[fg=grey,bold]${branch_name}"
  fi

  # Выводим итог
  echo "${branch}#[default]${dirty} | "
else
  echo ""
fi
