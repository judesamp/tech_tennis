module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        game, question = Game.start
        game.extend(GameRepresenter)
        question.extend(QuestionRepresenter)
        holder = {:game => game, :question => question}
        holder.to_json
      end     
      
      get '/play' do
        puts params
        
        puts params[:question][:game_id]
        puts params[:question][:question_id]
        puts params[:user_answer]
        
        attributes = { :id => params[:question][:game_id], 
                       :question_id => params[:question][:question_id],
                       :user_answer => params[:user_answer] }
        game, question = Game.play(attributes)
        game.extend(GameRepresenter)
        question.extend(QuestionRepresenter)
        holder = {:game => game, :question => question}
        holder.to_json
      end
    end
  end
end