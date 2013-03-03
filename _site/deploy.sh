#!/usr/bin/env bash

echo "Building with Jekyll..."
jekyll

echo "Packaging and deploying to GitHub master..."
echo "deploy `date`" | git commit-tree source^{tree}:_site -p $(cat .git/refs/heads/master)
git update-ref refs/heads/master COMMIT_ID
git checkout master
git push -f origin master

git checkout source

echo "Done!"
