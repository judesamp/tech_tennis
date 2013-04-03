require 'data_mapper'
require 'pg'
require 'dm-postgres-adapter'
require 'cgi'
require 'rspec'
require 'dm-rspec'
require 'rack/test'
#require 'factory'
#require 'factory_girl'
#require 'ffaker'


ENV['RACK_ENV'] = 'test'
config = YAML.load_file('config/database.yml')
DataMapper.setup(:default, config[ENV['RACK_ENV']])
DataMapper.finalize.auto_upgrade!

RSpec.configure do |conf|
 conf.include Rack::Test::Methods
 conf.include DataMapper::Matchers
 conf.before(:each) { DataMapper.auto_migrate! }
end

 
 