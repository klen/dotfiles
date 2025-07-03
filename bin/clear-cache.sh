#!/usr/bin/env bash
set -euo pipefail

# Universal Cache Cleaner Script
# Author: Kiro Maples (@horneds)

echo "=== Clearing Python pip cache ==="
pip cache purge || echo "pip not installed"

echo "=== Removing Python __pycache__ directories ==="
find . -type d -name "__pycache__" -exec rm -r {} + || true

echo "=== Removing Python *.egg-info directories ==="
find . -type d -name "*.egg-info" -exec rm -r {} + || true

echo "=== Removing Python build and dist directories ==="
find . -type d -name "build" -exec rm -r {} + || true
find . -type d -name "dist" -exec rm -r {} + || true

echo "=== Clearing Rust cargo cache ==="
if command -v cargo-cache &>/dev/null; then
  cargo cache -a
else
  cargo clean || echo "cargo clean skipped"
  rm -rf ~/.cargo/registry
  rm -rf ~/.cargo/git
fi

echo "=== Removing Rust target directory ==="
rm -rf target || true

echo "=== Removing Ruff cache ==="
rm -rf .ruff_cache || true

echo "=== Removing Mypy cache ==="
rm -rf .mypy_cache || true

echo "=== Clearing Yarn cache ==="
yarn cache clean || echo "yarn not installed"

echo "=== Removing node_modules and yarn.lock ==="
rm -rf node_modules || true
rm -f yarn.lock || true

echo "=== Clearing npm cache ==="
npm cache clean --force || echo "npm not installed"

echo "=== Clearing npx cache ==="
npx clear-npx-cache || echo "npx not installed or clear-npx-cache failed"

echo "=== Removing npm package-lock.json ==="
rm -f package-lock.json || true

echo "=== Cleaning Docker build cache and resources ==="
docker builder prune -f || echo "docker builder prune skipped"
docker image prune -af || echo "docker image prune skipped"
docker container prune -f || echo "docker container prune skipped"
docker volume prune -f || echo "docker volume prune skipped"
docker network prune -f || echo "docker network prune skipped"

echo "=== Clearing Poetry cache ==="
poetry cache clear pypi --all || echo "poetry not installed"

echo "=== Rehashing pyenv ==="
pyenv rehash || echo "pyenv not installed"

echo "=== Removing temporary swap files ==="
find . -type f -name "*.swp" -delete || true
find . -type f -name "*~" -delete || true

echo "=== macOS: Cleaning Homebrew and pip caches ==="
brew cleanup -s || echo "brew not installed"
rm -rf ~/Library/Caches/pip || true

echo "=== Cache cleaning completed successfully ==="
