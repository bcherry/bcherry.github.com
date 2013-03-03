#!/usr/bin/env bash

echo "Building with Jekyll..."
jekyll

echo "Packaging and deploying to GitHub master..."
git update-ref refs/heads/master $(echo 'Deploy `date`' | git commit-tree source^{tree}:_site -p $(cat .git/refs/heads/master))
git push -f origin master

git checkout source

echo "Done!"
