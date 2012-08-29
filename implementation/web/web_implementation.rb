require 'rubygems'
require 'sinatra'
require './domain/entities/game'
require 'Haml'

Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
  require file
end

module Implementation
  class Web < Sinatra::Base
    get '/' do
      haml :index
      
    end
  end
end
   