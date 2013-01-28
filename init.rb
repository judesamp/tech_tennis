require 'rubygems'
require 'sinatra/base'
require 'bundler/setup'
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

DataMapper::setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/tech_tennis")
DataMapper.auto_upgrade!

##DataMapper.finalize.auto_upgrade!

#require mongoid
# :mongo_db = blah





