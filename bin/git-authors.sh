#!/bin/sh

set -e

IFS='
'
for f in `git ls-tree -r --name-only ${1:-HEAD}`; do
        git blame -w -C -p "$f" | sed -n \
                -e '/^author /{ s/^author //; h; }' \
                -e '/^author-mail /{ s/^author-mail //; H; x; s/\n/ /p; }'
done | sort -u
