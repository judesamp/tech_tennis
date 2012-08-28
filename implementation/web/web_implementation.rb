require 'sinatra'
require './domain/entities/game'

Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
  require file
end

module Implementation
  class Web < Sinatra::Base
    get '/' do
      Domain::Game.new.greeter
    end
  end
end
   