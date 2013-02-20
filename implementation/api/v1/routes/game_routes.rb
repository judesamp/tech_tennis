module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        game = Game.start
        holder = Holder.new.extend(HolderRepresenter)
        holder.data = game
        puts "here is the game: #{holder.inspect}"
        #game.extend(PlayRepresenter).to_json
        puts holder.extend(DataRepresenter).to_json
      end     
      
      # game, question = Game.start
      #      holder = GameData.new.extend(GameDataRepresenter)
      #      holder.game = game
      #      holder.question = question
      #      holder.to_json
      
      
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