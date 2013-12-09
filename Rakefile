require "rubygems"
require "bundler/setup"

require "rspec/core/rake_task"

# The :environment task loads the application, models etc.
# Require it whenever you need to work with application classes.

task :environment do
  require "./environment"
end

# Test-related tasks.

RSpec::Core::RakeTask.new(:spec)
task :spec => :environment

# Define a default task.

task :default => :spec
