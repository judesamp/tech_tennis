module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        game = Game.start
        game.extend(GameRepresenter)
        # question.extend(QuestionRepresenter)
        # holder = {:game => game, :question => question}
        #         puts holder.to_json
        # holder.to_json
        game.to_json
      end     
      
      get '/play' do
        attributes = { :id => params[:question][:game_id], 
                       :question_id => params[:question][:id],
                       :user_answer => params[:user_answer] }
        game = Game.play(attributes)
        game.extend(GameRepresenter)
        game.to_json
      end
      
      
      get '/greetings' do
      	attributes = { :greetings => [{
      	    :id => "welcome_message",
      	    :greeting_text => "Welcome to TechTennis, an HTML quiz game based on the sport of kings. The score will start at 4-4 in the final set."
        }]}
        attributes.to_json
      end
      
      get '/mobile_start' do
        game = Game.start
        game.extend(GameRepresenter)
        # question.extend(QuestionRepresenter)
        # holder = {:game => game, :question => question}
        #         puts holder.to_json
        # holder.to_json
        new_game = (game.to_json)
        puts params[:callback] + "(#{new_game})"
        params[:callback] + "(#{game.to_json})"
        
      end
      
      get '/mobile_play' do
        puts params
        attributes = { :id => params[:id], 
                       :question_id => params[:question_id],
                       :user_answer => params[:user_answer] }
        game = Game.play(attributes)
        game.extend(GameRepresenter)
        puts game.user_game_score_translation
        puts game.opponent_game_score_translation
        puts params[:callback] + "(#{game.to_json})"
        params[:callback] + "(#{game.to_json})"
      end
    end
  end
end