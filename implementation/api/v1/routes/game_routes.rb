module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        game = Game.start
        holder = Bowl.new
        holder.game = game
        game.to_json
      end     
      
      get '/play' do
        attributes = { :game_id => params[:game_id], 
                       :question_id => params[:question_id],
                       :user_answer => params[:user_answer] }
        continued_game = Game.play(attributes)
        continued_game
        
      end
    end
    
  end
end