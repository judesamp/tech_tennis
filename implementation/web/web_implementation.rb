require 'rubygems'
require 'sinatra'
require './domain/entities/game'
require 'json'

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

      before do
        @game = Domain::Game.new
      end
    
    get '/' do
      @player_score = @game.player_score
      @cpu_score = @game.cpu_score
      @test = @game.retrieve_question
      @new_visit = @game.new_visit?
      @multiplechoice = @game.multiple_choice?
      @fillintheblank = @game.fill_in_the_blank?
      mustache :index
    end
    
    get '/json' do
      puts params
      @game.retrieve_question.to_json
    end
    
    get '/user_answer' do
      
    end
    
    
    get '/clock' do
       mustache :clock, :layout => false
    end
    
    
    
   end
 end

   
 
   