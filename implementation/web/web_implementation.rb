require 'rubygems'
require 'sinatra'
require './domain/entities/game'
require 'json'
require 'CGI'
require 'data_mapper'
require 'dm-validations'


Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
  require file
end

Dir.glob(File.expand_path("./persistence") +"/*.rb").each do |file|
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
      @new = Domain::Game.new
      y = 
      x = @new.all_questions
      puts x
      @quiz = Persistence::Quiz.create(:quiz_id => "HTML")

      
      x.each do |question_array|
        @questions = Persistence::Question.create(question_array)
      end
      
      puts Persistence::Question.all().inspect
      
      
         
     
      
      
      
=begin
      @player_score = @game.player_score
      @cpu_score = @game.cpu_score
      @test = @game.retrieve_question
      @new_visit = @game.new_visit?
      @multiplechoice = @game.multiple_choice?
      @fillintheblank = @game.fill_in_the_blank?
=end
      
      
      mustache :index
    end
    
   
     
    get '/clock' do
       mustache :clock, :layout => false
    end
    
    
    
   end
 end

   
 
   