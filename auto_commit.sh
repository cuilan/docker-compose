#!/bin/bash

echo -e "\033[0;32mAuto commit and push to GitHub...\033[0m"

# Add changes to git.
git add .

# Commit changes.
msg="auto commit and push by `whoami` on `date +'%Y-%m-%d %H:%M:%S'`"

if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin main

