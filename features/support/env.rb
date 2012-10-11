rrequire "./init"
require 'rspec'
require 'rspec/expectations'
require 'rack/test'
require 'capybara'
require 'capybara/cucumber'

Capybara.app = eval("Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../../config.ru') + "\n )}")

class TestingWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
  set :environment, :test
end

World do
  TestingWorld.new
end