source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in make_space_great_again.gemspec
gemspec

# pulling from git because of an issue between pry and ruby 2.7
# https://github.com/pry/pry/issues/2097
gem 'pry', git: 'https://github.com/pry/pry.git', ref: '272b3290b5250d28ee82a5ff65aa3b29b825e37b'
