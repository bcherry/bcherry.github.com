#!/usr/bin/env ruby

if `git rev-parse --abbrev-ref HEAD`.strip != "source"
  puts "Please run this script from the source branch!"
  exit(1)
end

if `git diff-index HEAD --`.strip
  puts "Commit changes before deploying!"
  exit(1)
end

# echo "Changing to the 'build' branch..."
# git checkout build
# git merge source

# echo "Building with Jekyll..."
# jekyll

# echo "Pushing the build..."
# git commit -am "Build `date`"
# git push origin build

# echo "Merging the build to master and pushing to GitHub..."
# git update-ref refs/heads/master $(echo 'Deploy `date`' | git commit-tree build^{tree}:_site -p $(cat .git/refs/heads/master))
# git push -f origin master

# echo "Returning to the source branch..."
# git checkout source

# echo "Done!"
