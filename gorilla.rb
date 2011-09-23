require 'rubygems'
require 'bundler'
Bundler.require

begin
  Goliath.env
rescue => e
  Goliath.env = :dev
end

class Heartbeat < Goliath::API
  use Goliath::Rack::Validation::RequestMethod, %w(GET)

  def response(env)
    [200, {}, "OK"]
  end
end

class Environment < Goliath::API
  use Goliath::Rack::Validation::RequestMethod, %w(GET)

  def response(env)
    [200, {}, Goliath.env]
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
  use ::Rack::Reloader, 0 if Goliath.dev?

  map '/status' do
    run Heartbeat.new
  end

  map '/env' do
    run Environment.new
  end

  map '/' do
    run Hello.new
  end
end
