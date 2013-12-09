require "rspec"
require "rack/test"

ENV["RACK_ENV"] = "test"

require File.expand_path("../../application", __FILE__)

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
