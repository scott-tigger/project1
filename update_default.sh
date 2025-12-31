#!/usr/bin/env bash
set -euo pipefail

# Script to rename the current branch to PRODUCTION, push it to origin,
# attempt to set the GitHub default branch (requires `gh`), and delete remote
# master branch if present.

cd "$(git rev-parse --show-toplevel)"

current=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || true)
if [ "$current" = "PRODUCTION" ]; then
  echo "Local branch already named PRODUCTION"
else
  if [ -n "$current" ]; then
    git branch -m PRODUCTION
    echo "Renamed local branch '$current' -> PRODUCTION"
  else
    echo "No current branch detected; aborting" >&2
    exit 1
  fi
fi

# Push new branch and set upstream if remote exists
if git remote | grep -q origin; then
  echo "Pushing PRODUCTION to origin..."
  git push -u origin PRODUCTION
else
  echo "No 'origin' remote configured; skipping push"
fi

# Try to set default branch on GitHub if gh is installed
if command -v gh >/dev/null 2>&1; then
  repo_url=$(git remote get-url origin 2>/dev/null || true)
  if [ -n "$repo_url" ]; then
    echo "Setting GitHub default branch to PRODUCTION via gh..."
    gh repo edit --default-branch PRODUCTION || echo "gh failed to set default branch"
  else
    echo "No origin URL; skipping gh repo edit"
  fi
else
  echo "gh CLI not found; skipping remote default branch update"
fi

# Attempt to delete remote 'master' branch (may fail if it's default)
if git remote | grep -q origin; then
  echo "Attempting to delete remote 'master' branch (may fail if it's default)..."
  git push origin --delete master || echo "Failed to delete remote 'master' (it may not exist or be protected)"
else
  echo "No 'origin' remote; skipping remote branch deletion"
fi

echo "Done. Verify remote settings on GitHub if necessary."
