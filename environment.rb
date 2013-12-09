require "rubygems"
require "bundler"

Bundler.require(:default, ENV["RACK_ENV"] || "development")

Dir[File.join(settings.root, "lib/**/*.rb")].each { |file| require file }

configure :test do
end

# To use caching for application responses:
# 1. uncomment the rack-cache configurations below
# 2. tweak caching options according to your needs (optional)
# 3. set cache headers in routes, e.g. using sintatra's `expires` helper

configure :development do
  # use Rack::Cache,
  #   metastore:   "heap:/",
  #   entitystore: "heap:/"
end

configure :production do
  # cache = Dalli::Client.new

  # use Rack::Cache,
  #   metastore:   cache,
  #   entitystore: cache
end
