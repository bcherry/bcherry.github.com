#!/usr/bin/env ruby

if `git rev-parse --abbrev-ref HEAD`.strip != "source"
  puts "Please run this script from the source branch!"
  exit(1)
end

unless `git diff-index HEAD --`.strip.size == 0
  puts "Commit changes before deploying!"
  exit(1)
end

puts "Changing to the 'build' branch..."
`git checkout build`
`git merge source`

puts "Building with Jekyll..."
`jekyll`

puts "Pushing the build..."
`touch _site/.jekyllignore`
`git add .`
`git commit -am "Build #{`date`}"`
`git push origin build`

puts "Merging the build to master and pushing to GitHub..."
`git update-ref refs/heads/master $(echo 'Deploy #{`date`}' | git commit-tree build^{tree}:_site -p $(cat .git/refs/heads/master))`
`git push -f origin master`

puts "Returning to the source branch..."
`git checkout source`

puts "Done!"
