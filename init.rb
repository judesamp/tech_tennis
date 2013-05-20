require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'thin'
require 'shotgun'
require 'mustache/sinatra'
require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'
require 'data_mapper'
require 'dm-postgres-adapter'


Bundler.require(:default)

# Load all domain files.
Dir["./domain/**/*.rb"].each do |file|
  require file
end

# Load all implementation files.
Dir["./implementation/**/*.rb"].each do |file|
  require file
end

# Load all persistence files.
Dir["./persistence/**/*.rb"].each do |file|
  require file
end

# ENV['RACK_ENV'] = 'development'
# config = YAML.load_file('config/database.yml')
# DataMapper.setup(:default, config[ENV['RACK_ENV']])
# DataMapper.finalize.auto_upgrade!

 DataMapper::setup(:default, (ENV['DATABASE_URL'] || "postgres://localhost/tech_tennis"))
  DataMapper.auto_upgrade!

##DataMapper.finalize.auto_upgrade!

#require mongoid
# :mongo_db = blah





