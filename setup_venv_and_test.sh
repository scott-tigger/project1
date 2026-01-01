#!/usr/bin/env bash
set -euo pipefail

# Simple helper to create a reproducible .venv and run tests.
# It prefers pyenv's 3.12.8 if available, otherwise falls back to `python3` on PATH.

cd "$(dirname "$0")"

PYENV_BIN=""
if command -v pyenv >/dev/null 2>&1; then
  PYENV_PREFIX=$(pyenv prefix 3.12.8 2>/dev/null || true)
  if [ -n "$PYENV_PREFIX" ]; then
    PYENV_BIN="$PYENV_PREFIX/bin/python"
  fi
fi

PYTHON_BIN=${PYENV_BIN:-$(command -v python3 || echo python3)}
echo "Using interpreter: $PYTHON_BIN"

rm -rf .venv
"$PYTHON_BIN" -m venv .venv
. .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel

if [ -f requirements.txt ]; then
  pip install -r requirements.txt
fi

echo "Running tests with: $(python -V)"
python -m pytest -q "$@"

echo "Done."
