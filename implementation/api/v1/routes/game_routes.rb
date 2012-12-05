module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        @game = Domain::Game.new(2)
        @begin_game_data_send = Play.new.extend(PlayRepresenter)
        @begin_game_data_send.from_json(@game.retrieve_begin_game_data)
        @begin_game_data_send.to_json
      end     
      
      get '/play' do
        @continued_game = Domain::Game.find_game(params[:game_data_id])
        @answer = @continued_game.process_answer(params[:game_data_id], params[:id], params[:user_answer])
        @score_now = @continued_game.process_score(params[:game_data_id])
        @continued_game_data_send = Play.new.extend(PlayRepresenter)
        @continued_game_data_send.from_json(@continued_game.retrieve_continued_game_data(params[:game_data_id], @score_now))
        @continued_game_data_send.to_json
        
        # print "User: "
        #         puts @score_now[:user_game]
        #         print "CPU: "
        #         puts @score_now[:opponent_game]
        #         puts @score_now[:last_result]
        
        # consume!(@game, :represent_with => AnswerRepresenter) 
      end
    end
    
  end
end