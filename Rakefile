require "rubygems"
require "bundler/setup"

# The :environment task loads the application, models etc.
# Require it whenever you need to work with application classes.

task :environment do
  require "./environment"
end

# Test-related tasks.

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)
  task :spec => :environment
rescue
  # install rspec to run specs
end

# Define a default task.

task :default => :spec
