#!/usr/bin/env bash

cd "${1:-$PWD}"

if git rev-parse --is-inside-work-tree &>/dev/null; then
  # Branch name
  branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)

  # Check local changes
  if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    has_local_changes=1
    dirty=" *"
  else
    has_local_changes=0
    dirty=""
  fi

  # Check divergence from upstream
  upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)

  if [[ -n "$upstream" ]]; then
    diff=$(git rev-list --left-right --count HEAD...${upstream} 2>/dev/null)
    left=${diff%%	*}
    right=${diff##*	}

    if [[ "$left" -ne 0 || "$right" -ne 0 ]]; then
      # Diverged from origin → red
      branch="#[fg=red]${branch_name}"
    elif [[ "$has_local_changes" -eq 1 ]]; then
      # Local changes, no divergence → yellow
      branch="#[fg=yellow]${branch_name}"
    else
      # Clean, no divergence → default (no colour)
      branch="${branch_name}"
    fi
  else
    # No upstream → grey
    branch="#[fg=grey]${branch_name}"
  fi

  # Print result
  echo "$(echo "$branch" | tr '[:lower:]' '[:upper:]')#[fg=default]${dirty} | "
else
  echo ""
fi
