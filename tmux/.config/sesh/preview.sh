#!/bin/bash

SOURCE=$@
echo "Previewing $SOURCE"

[[ -f "$SOURCE/README.md" ]] && {
  bat "$SOURCE/README.md"
  return
}

ls -la "$SOURCE"
