module Implementation
  class Mobile < Sinatra::Base
    set :public_folder, "implementation/mobile/public"
   
    get '/' do
      
      erb :index
    end
  end
end