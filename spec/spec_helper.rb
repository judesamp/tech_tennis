require 'rspec'
require 'rack/test'
require 'JSON'
require 'data_mapper'
require 'dm-postgres-adapter'

#load all your stuff either explicitly:
require_relative '../domain/entities/game'
#require_relative "../../persistence/game_datum" #why necessary
# require_relative 'player'
require 'cgi'
require 'pg'


# this MIGHT work for the whole deal
Dir.glob(File.expand_path("./domain") +"/**/*.rb").each do |file|
   require file
 end
 
 # Dir["./persistence/**/*.rb"].each do |file|
 #    require file
 #  end
 

 
 