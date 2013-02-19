module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        game, question = Game.start
        holder = GameData.new.extend(GameDataRepresenter)
        holder.game = game
        holder.question = question
        holder.to_json
      end     
      
      get '/play' do
        attributes = { :game_id => params[:question][:game_id], 
                       :question_id => params[:question][:question_id],
                       :user_answer => params[:user_answer] }
        game, question = Game.play(attributes)
        holder = GameData.new.extend(GameDataRepresenter)
        holder.game = game
        holder.question = question
        puts holder.to_json
        holder.to_json
      end
    end
  end
end