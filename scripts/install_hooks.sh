#!/bin/bash
set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOOKS_DIR="$PROJECT_ROOT/.git/hooks"

if [ ! -d "$PROJECT_ROOT/.git" ]; then
    echo "Ошибка: запустите скрипт внутри Git-репозитория."
    exit 1
fi

cp "$PROJECT_ROOT/scripts/pre-commit" "$HOOKS_DIR/pre-commit"
cp "$PROJECT_ROOT/scripts/post-commit" "$HOOKS_DIR/post-commit"
chmod +x "$HOOKS_DIR/pre-commit" "$HOOKS_DIR/post-commit"

echo "Hooks installed:"
echo "  .git/hooks/pre-commit"
echo "  .git/hooks/post-commit"
