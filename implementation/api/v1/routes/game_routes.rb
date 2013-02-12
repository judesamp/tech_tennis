module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        @game = Game.start
        puts @game.inspect
        @game
       # puts @game.inspect
       #         @game.extend(PlayRepresenter).to_json
      
        
        #extend(PlayRepresenter).to_json
        # @game = Domain::Game.create
        # @game.save
        # @game.add_default_questions
        # @begin_game_data_send = Play.new.extend(PlayRepresenter)
        # @begin_game_data_send.from_json(@game.retrieve_begin_game_data(@game.id))
        # @begin_game_data_send.to_json
      end     
      
      get '/play' do
        attributes = { :game_id => params[:game_id], 
                       :question_id => params[:question_id],
                       :user_answer => params[:user_answer] }
        continued_game = Game.play(attributes)
        puts continued_game.inspect
        continued_game
        
        
        #puts after play
        #continued_game = Play.new.extend(PlayRepresenter).to_json
        #puts "continued game: #{continued_game}"
      end
    end
    
  end
end