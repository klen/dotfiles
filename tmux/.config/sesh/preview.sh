#!/bin/bash

SOURCE=$@

[[ -f "$SOURCE/README.md" ]] && {
  bat --color=always "$SOURCE/README.md"
  return
}

(command -v gls >/dev/null && gls --color=always -1 --group-directories-first "$SOURCE" || CLICOLOR_FORCE=1 ls -G -1 "$SOURCE")
