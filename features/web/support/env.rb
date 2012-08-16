require_relative "../../implementation/web/web_implementation"
 
require "Capybara"
require "Capybara/cucumber"
require "rspec"
 
 
World do
  Capybara.app = Implementation::Web
 
  include Capybara::DSL
  include RSpec::Matchers
end
