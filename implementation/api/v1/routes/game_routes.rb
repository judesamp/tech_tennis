module Implementation
  module API
    class V1 < Sinatra::Base
      
      get '/start' do
        @game = Game.start
        puts Play.new(@game, @game.questions.least_asked).extend(PlayRepresenter).to_json
       
       
      
       
        #extend(PlayRepresenter).to_json
        # @game = Domain::Game.create
        # @game.save
        # @game.add_default_questions
        # @begin_game_data_send = Play.new.extend(PlayRepresenter)
        # @begin_game_data_send.from_json(@game.retrieve_begin_game_data(@game.id))
        # @begin_game_data_send.to_json
      end     
      
      get '/play' do
        attributes = { :id => params[:id], 
                       :question_id => params[:question_id],
                       :user_answer => params[:user_answer] }
        @game = Game.play(attributes)
        @game.extend(PlayRepresenter).to_json
      end
    end
    
  end
end