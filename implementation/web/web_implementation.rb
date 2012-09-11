require 'rubygems'
require 'sinatra'
require './domain/entities/game'
require 'Haml'

Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
  require file
end

module Implementation
  class Web < Sinatra::Base
    register Mustache::Sinatra
      require './implementation/web/views/web_layout'
      set :public_folder, "implementation/web/public"
      set :view, "implementation/web/templates"
      set :mustache, {
        :views => 'implementation/web/views/',
        :templates => 'implementation/web/templates/'
      }

      
    
    get '/' do
      @game = Domain::Game.new
      @player_score = @game.player_score
      @opponent_score = @game.opponent_score
      
      mustache :index
    end
    
   
  end
end
   