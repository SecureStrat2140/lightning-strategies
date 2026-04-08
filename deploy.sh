#!/bin/bash
# ⚡ Lightning Strategies — Deploy to GitHub Pages
# Usage: ./deploy.sh "Your commit message here"
# Or just: ./deploy.sh (uses auto-generated message)

REPO_DIR="/mnt/claude-ssd/Lightning-Strategies/repo"
cd "$REPO_DIR" || { echo "❌ Repo directory not found"; exit 1; }

# Default commit message if none provided
MSG="${1:-"⚡ Website update — $(date '+%Y-%m-%d %H:%M')"}"

# Check for changes
if git diff --quiet && git diff --cached --quiet; then
  echo "⚡ No changes detected. Nothing to deploy."
  exit 0
fi

# Stage, commit, push
echo "⚡ Staging changes..."
git add -A

echo "⚡ Committing: $MSG"
git commit -m "$MSG"

echo "⚡ Pushing to GitHub..."
git push origin main 2>/dev/null || git push origin master

echo ""
echo "⚡ ═══════════════════════════════════════"
echo "⚡  DEPLOYED SUCCESSFULLY"
echo "⚡  Site: https://lightningstrategies.me"
echo "⚡  Changes go live in 1-2 minutes"
echo "⚡ ═══════════════════════════════════════"
