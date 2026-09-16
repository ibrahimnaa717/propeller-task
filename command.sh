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

# Step 5: commit logo and link updates
git add .
git commit -m "Replace React logo with Propeller logo and update link to DirtMate"

# Step 6: create GitHub repository and push branches
gh repo create propeller-task --public --source=. --remote=origin
git push -u origin master
git push -u origin update_logo

# Step 7: create Pull Request
gh pr create --base master --head update_logo --title "Update logo and link" --body "Replace React logo with Propeller logo and Learn React link with DirtMate link"

# Step 8: merge Pull Request
gh pr merge update_logo --merge

# REPO_URL https://github.com/ibrahimnaa717/propeller-task