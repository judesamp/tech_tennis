module Implementation
  module API
    class V1 < Sinatra::Base
      get '/question' do
        @game = Domain::Game.new
        @game.retrieve_question.to_json
        puts params
        
      end
      get '/answer' do
        puts params
      end
    end
  end
end