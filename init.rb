require 'rubygems'
require 'sinatra/base'
require 'bundler/setup'
require 'thin'
require 'shotgun'

Bundler.require(:default)

# Load all domain files.
Dir["./domain/**/*.rb"].each do |file|
  require file
end

# Load all implementation files.
Dir["./implementation/**/*.rb"].each do |file|
  require file
end


