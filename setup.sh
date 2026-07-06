#!/usr/bin/env bash
# Initializes a local git repo in each project folder, makes the first commit,
# and (if the GitHub CLI `gh` is installed and you're logged in) creates the
# matching repo on GitHub and pushes it.
#
# Usage:
#   chmod +x setup.sh
#   GITHUB_USERNAME=yourusername ./setup.sh
set -e

USERNAME="${GITHUB_USERNAME:-your-github-username}"
PROJECTS=("profile-repo" "malaria-forecasting-pipeline" "cost-of-illness-toolkit" "results-table-automation")

echo "Setting up local git repos for: ${PROJECTS[*]}"
echo "GitHub username: $USERNAME"
echo

for project in "${PROJECTS[@]}"; do
  echo "--- $project ---"
  cd "$project"

  if [ ! -d .git ]; then
    git init -q
    git add .
    git commit -q -m "Initial commit"
    echo "  git repo initialized and first commit made"
  else
    echo "  already a git repo, skipping init"
  fi

  if command -v gh &> /dev/null; then
    if gh auth status &> /dev/null; then
      REPO_NAME="$project"
      if [ "$project" == "profile-repo" ]; then
        REPO_NAME="$USERNAME"
      fi

      if gh repo view "$USERNAME/$REPO_NAME" &> /dev/null; then
        echo "  GitHub repo $USERNAME/$REPO_NAME already exists, skipping create"
      else
        gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
        echo "  created and pushed to https://github.com/$USERNAME/$REPO_NAME"
      fi
    else
      echo "  'gh' is installed but not authenticated. Run 'gh auth login' first."
    fi
  else
    echo "  'gh' (GitHub CLI) not found."
    echo "  To push manually:"
    echo "    1. Create an empty repo named '$project' (or '$USERNAME' for profile-repo) on github.com"
    echo "    2. cd $project"
    echo "    3. git remote add origin https://github.com/$USERNAME/$project.git"
    echo "    4. git branch -M main && git push -u origin main"
  fi

  cd ..
  echo
done

echo "Done."
