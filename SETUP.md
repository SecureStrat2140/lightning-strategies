# One-Time GitHub Setup

Run these commands **once** from your Mac Terminal to wire this folder up to `github.com/SecureStrat2140/lightning-strategies`. After that, `./push.sh` handles everything going forward.

## Step 1 — Open Terminal inside this folder

```bash
cd ~/path/to/Chief-Marketing-Officer/Context
```

Tip: in Finder, right-click the `Context` folder → Services → "New Terminal at Folder."

## Step 2 — Confirm GitHub auth

If you have the GitHub CLI:

```bash
gh auth status
```

If you see "Logged in to github.com as SecureStrat2140," you're good. If not:

```bash
gh auth login
```

No `gh`? You can authenticate via SSH key or HTTPS + Personal Access Token. Easiest: install `gh` with `brew install gh`, then `gh auth login`.

## Step 3 — Initialize the repo and connect to GitHub

```bash
git init
git branch -M main
git remote add origin https://github.com/SecureStrat2140/lightning-strategies.git
```

## Step 4 — (If the repo doesn't exist yet) create it

Skip this step if the repo already exists on GitHub.

```bash
gh repo create SecureStrat2140/lightning-strategies \
  --public \
  --description "Lightning Strategies — Chief Bitcoin Officer as a Service" \
  --source=. \
  --remote=origin \
  --push=false
```

## Step 5 — First commit + push

```bash
git add -A
git commit -m "chore: initial commit — Lightning Strategies website source"
git push -u origin main
```

The `-u` flag sets the upstream so all future `./push.sh` runs just work.

## Step 6 — Verify

```bash
./push.sh docs "verify push workflow"
```

If you see `✓ Done. Commit pushed.`, you're wired up.

## Going forward

From now on, any time we make edits in this folder:

```bash
./push.sh feat "add advisory council page"
./push.sh fix  "correct hero CTA link"
./push.sh docs "update manifesto copy"
```

Or just `./push.sh` for the interactive prompt version.

## Troubleshooting

- **"Permission denied" on push.sh** → run `chmod +x push.sh`
- **"remote origin already exists"** → `git remote set-url origin https://github.com/SecureStrat2140/lightning-strategies.git`
- **Push rejected (non-fast-forward)** → someone else pushed; run `git pull --rebase origin main` then `./push.sh` again
- **Large files warning** → move binaries (logos, icons) to Git LFS or keep them under 50 MB (all current files are fine)
