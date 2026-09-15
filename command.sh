#!/usr/bin/env bash
# Command log for propeller-task workflow. Run from Git Bash.

# Step 0: report tool versions
node -v
git --version

# Step 1: scaffold React app (retry via temp subfolder, then merge up)
npx create-react-app@latest temp-app
shopt -s dotglob nullglob
mv temp-app/* .
rmdir temp-app

# Step 2: verify CRA's initial commit and branch, rename to master
git log --oneline
git branch --show-current
git branch -M master

# Step 3: create update_logo branch
git checkout -b update_logo

# Step 4: download Propeller logo into src/ (first URL 404'd, retried with this one)
curl.exe -fsSL -o src/propeller-logo.svg "https://www.propelleraero.com/wp-content/uploads/2023/05/footer-logo.svg"
