require 'json'
require 'CGI'

module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        @game = Domain::Game.new
        @start_game = Play.new.extend(PlayRepresenter)
        @game_data = {:user_game => "0", :opponent_game => "0", :last_result => false}
        @start_game.question_data = @game.retrieve_question
        @start_game.game_data = @game_data
        
        puts @start_game.to_json.inspect
        
        @start_game.to_json
        
        
        
        
        #puts @response.to_json
        
      
        # return first message/question to be displayed
        # return the game id, which you need to use on the nest jQuery JSON post.
      end     
      
      get '/play' do
        puts params
        @game = Domain::Game.new
        
        @answer = @game.process_answer(params[:question_data][:game_data_id], params[:question_data][:id], params[:question_data][:user_answer])
        @score_now = @game.process_score(params[:question_data][:game_data_id])
        puts @score_now.inspect
        
        puts @answer.to_s
       
        print "User: "
        puts @score_now[:user_game]
        print "CPU: "
        puts @score_now[:opponent_game]
        puts @score_now[:last_result]
       
        @continued_game = Play.new.extend(PlayRepresenter)
        @continued_game_data = {:user_game => @score_now[:user_game], :opponent_game => @score_now[:opponent_game], :last_result => @answer}
        @continued_game.question_data = @game.retrieve_question(params[:question_data][:game_data_id])
        @continued_game.game_data = @continued_game_data
        puts "play"
        puts @continued_game.to_json.inspect
        @continued_game.to_json
        
       
        
       
          
         
        
        
        
        
    
        
        
       #params[:user_answer]
        
        #@game = Domain::Game.find_game(params[:game_data_id])
  
        #puts @game.retrieve_question(params[:game_data_id]).to_json
        #@game.retrieve_question(params[:game_data_id]).to_json
        
        #@game = Domain::Game.find_game(params[:game_data_id])
        #puts @game.inspect
        #puts @game.retrieve_question
      
        
        # post the game id
        # post the current answer
        # play should respond with next question, message or end game.
        # play should respond with game_id
        #@game = Domain::Game.find(:id)
        # move to Domain
        #@response = []
        #@response << @game.retrieve_question
        #@response << @game
        #@response.extend(PlayRepresenter)
        #@response.to_json
        
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