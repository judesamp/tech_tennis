module Implementation
  class Web < Sinatra::Base
    get '/profile' do
      "Edit your profile"
    end
  end
end 