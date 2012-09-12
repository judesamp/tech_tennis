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
      game = Domain::Game.new
      @player_score = game.player_score
      @cpu_score = game.cpu_score
      @question = game.retrieve_question
      @answer_a = game.retrieve_answers[0]
      @answer_b = game.retrieve_answers[1]
      @answer_c = game.retrieve_answers[2]
      @answer_d = game.retrieve_answers[3]
      
      
      mustache :index
    end
   
   post "/" do
     @answer = params{:}
     
    end 
   
  end
end
   