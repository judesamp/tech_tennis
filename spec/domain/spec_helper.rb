require 'rspec'
require 'rack/test'
require 'JSON'

#load all your stuff either explicitly:
require './domain/entities/game'
#require_relative "../../persistence/game_datum" #why necessary
# require_relative 'player'
require 'cgi'

require 'pg'
require "dm-postgres-adapter"

# this MIGHT work for the whole deal
Dir.glob(File.expand_path("./domain") +"/**/*.rb").each do |file|
   require file
 end
 
 Dir["./persistence/**/*.rb"].each do |file|
   require file
 end
 
 RSpec.configure do |config|
   config.include Rack::Test::Methods
   DataMapper.setup :default, 'postgres://localhost/tech_tennis_test'
   DataMapper.finalize
   DataMapper.auto_migrate!
 end
 
 