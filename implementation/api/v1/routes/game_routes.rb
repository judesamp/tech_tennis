require 'digest/sha1'
include ObjectSpace

module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/question' do
        @game = Domain::Game.new
        @question = @game.retrieve_question
        @question[:answer_options].map! {|value| CGI::escapeHTML(value)}
        @question.to_json
      end
      get '/answer' do
        puts params
        @game_object = Domain::Game.find_by_id(@game_id)
        puts params
       
        @game_object.process_answer(params["user_answer"])
        
        
       
       
        
        
        
         
        
      end
    end
    
  end
end