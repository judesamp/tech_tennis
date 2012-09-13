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
      @test = game.retrieve_question
      @question = @test[0]
      @answer_a = @test[1][0]
      @answer_b = @test[1][1]
      @answer_c = @test[1][2]
      @answer_d = @test[1][3]
      mustache :index
    end
   
   post "/" do
     
    end 
   
  end
end
   