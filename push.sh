#!/usr/bin/env bash
# push.sh — Lightning Strategies website auto-push helper
# Usage:
#   ./push.sh                      # interactive
#   ./push.sh <type> "<message>"   # one-liner
# Types: feat | fix | docs | style | refactor | chore

set -euo pipefail

# Work from the directory this script lives in
cd "$(dirname "$0")"

BRANCH="${BRANCH:-main}"
REMOTE="${REMOTE:-origin}"

# --- guards ---------------------------------------------------------------
if ! command -v git >/dev/null 2>&1; then
  echo "✗ git is not installed" >&2; exit 1
fi

if [ ! -d .git ]; then
  echo "✗ Not a git repo. Run the one-time setup first (see README)." >&2
  exit 1
fi

# --- parse args ----------------------------------------------------------
VALID_TYPES="feat fix docs style refactor chore"

TYPE="${1:-}"
MSG="${2:-}"

if [ -z "$TYPE" ]; then
  echo "Commit type? (feat | fix | docs | style | refactor | chore)"
  read -r -p "> " TYPE
fi

# Validate type
if ! echo " $VALID_TYPES " | grep -q " $TYPE "; then
  echo "✗ Invalid type '$TYPE'. Must be one of: $VALID_TYPES" >&2
  exit 1
fi

if [ -z "$MSG" ]; then
  echo "Commit message? (imperative, no period)"
  read -r -p "> " MSG
fi

if [ -z "$MSG" ]; then
  echo "✗ Empty commit message" >&2; exit 1
fi

FULL_MSG="${TYPE}: ${MSG}"

# --- preview -------------------------------------------------------------
echo
echo "── Changes to be committed ──────────────────────────────────────────"
git add -A
git status --short
echo
echo "── Commit message ───────────────────────────────────────────────────"
echo "$FULL_MSG"
echo

# Bail if nothing staged
if git diff --cached --quiet; then
  echo "✓ Nothing to commit. Tree is clean."
  exit 0
fi

read -r -p "Commit and push to $REMOTE/$BRANCH? [y/N] " CONFIRM
case "$CONFIRM" in
  y|Y|yes|YES) ;;
  *) echo "✗ Aborted."; git reset >/dev/null; exit 1 ;;
esac

# --- commit + push -------------------------------------------------------
git commit -m "$FULL_MSG"

echo
echo "── Pushing to $REMOTE/$BRANCH ──────────────────────────────────────"
git push "$REMOTE" "$BRANCH"

echo
echo "✓ Done. Commit pushed."
