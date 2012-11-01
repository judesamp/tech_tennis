require 'json'

module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        # puts "start"
        #         @game = Domain::Game.new
        #         @response = Play.new.extend(PlayRepresenter)
        #          @response.question_data = @game.retrieve_question
        #           @response.game_data = @game.retrieve_game_data
        #           puts @response.to_json
        #           @response.to_json
          @x = {"question" => "What?"}
          puts @x.to_json
          @x.to_json
          
        
          
        
          
          
          
          
        # return first message/question to be displayed
        # return the game id, which you need to use on the nest jQuery JSON post.
      end     
      
      post '/play' do
        # post the game id
        # post the current answer
        # play should respond with next question, message or end game.
        # play should respond with game_id
        @game = Domain::Game.find(:id)
        # move to Domain
        # @question[:answer_options].map! {|value| CGI::escapeHTML(value)}
        @response = []
        @response << @game.retrieve_question
        @response << @game
        @response.extend(PlayRepresenter)
        @response.to_json
        
        #player_id = 1
        #user = Persistence::User.get(player_id)
        #user[:variable]
        #gamedata = Persistence::Gamedata.get(player_id)
        #gamedata[:variable]
        #quiz_create = Persistence::Question.get()
        #quiz_create[:variable]
        #puts user[:user_type]
        #puts gamedata[:user_score]
        #quiz_create[:question]
      end
    end
    
  end
end