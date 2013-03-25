module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        game, question = Game.start
        game.extend(GameRepresenter)
        question.extend(QuestionRepresenter)
        holder = {:game => game, :question => question}
        puts holder.to_json
        holder.to_json
      end     
      
      get '/play' do
        attributes = { :id => params[:question][:game_id], 
                       :question_id => params[:question][:id],
                       :user_answer => params[:user_answer] }
        game, question = Game.play(attributes)
        game.extend(GameRepresenter)
        question.extend(QuestionRepresenter)
        holder = {:game => game, :question => question}
        holder.to_json
      end
      
      
      get '/greetings' do
      	attributes = { :greetings => [{
      	    :id => "welcome_message",
      	    :greeting_text => "Welcome to TechTennis, an HTML quiz game based on the sport of kings. The score will start at 4-4 in the final set."
        }]}
        attributes.to_json
      end
      
       get '/games' do
          game, question = Game.start
          puts game.inspect
          puts question.inspect
          game.extend(GameRepresenter)
          question.extend(QuestionRepresenter)
          holder = {:games => [game], :questions => [question]}
          puts holder.to_json
          holder.to_json
        end
        
         # get '/questions' do
         #          game, question = Game.start
         #          puts game.inspect
         #          puts question.inspect
         #          game.extend(GameRepresenter)
         #          question.extend(QuestionRepresenter)
         #          holder = {:questions => [question]}
         #          puts holder.to_json
         #          holder.to_json
         #        end
        
        
        
         post '/games' do
            attributes = { :id => params[:question][:game_id], 
                           :question_id => params[:question][:id],
                           :user_answer => params[:user_answer] }
            game, question = Game.play(attributes)
            game.extend(GameRepresenter)
            question.extend(QuestionRepresenter)
            dataegg = game.merge(question)
            holder = {:games => dataegg}
            holder.to_json
          end
      
      
      
    end
  end
end