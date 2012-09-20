module Implementation
  module API
    class V1 < Sinatra::Base
      get '/question' do
        puts params
        @game.retrieve_question.to_json
      end
      put '/answer' do
        
      end
    end
  end
end