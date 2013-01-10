module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        @user = Domain::User.get(2)
        @game = Domain::Game.create
        @game.user = @user
        @game.save
        @game.add_default_questions(@game.id)
        
        puts @user.id
        @begin_game_data_send = Play.new.extend(PlayRepresenter)
        @begin_game_data_send.from_json(@game.retrieve_begin_game_data(@user.id))
        @begin_game_data_send.to_json
      end     
      
      get '/play' do
        puts "Hello, here we go: #{params}"
        @continued_game = Domain::Game.get(params[:game_id])
        puts @continued_game.inspect
        @processing_answer_and_score = Play.new.extend(PlayRepresenter)
        @processing_answer_and_score.from_json(@continued_game.process_answer_and_score(params[:game_id], params[:id], params[:user_answer]))
        @processing_answer_and_score.to_json 
        # consume!(@game, :represent_with => AnswerRepresenter) 
      end
    end
    
  end
end