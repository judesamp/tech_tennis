module Implementation
  class Web < Sinatra::Base
    get '/play' do
      "Play the game"
    end
  end
end