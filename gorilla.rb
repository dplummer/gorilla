require 'rubygems'
require 'bundler'
Bundler.require

class Heartbeat < Goliath::API
  use Goliath::Rack::Validation::RequestMethod, %w(GET)

  def response(env)
    [200, {}, "OK"]
  end
end

class Hello < Goliath::API
  # default to JSON output, allow Yaml as secondary
  use Goliath::Rack::Render, %w(json)

  def response(env)
    [200, {}, "Hello World"]
  end
end

class Gorilla < Goliath::API
  map '/status' do
    run Heartbeat.new
  end

  map '/' do
    run Hello.new
  end
end
