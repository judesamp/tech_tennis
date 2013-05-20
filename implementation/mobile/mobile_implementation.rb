module Implementation
  class Mobile < Sinatra::Base
    set :public_folder, "implementation/mobile/public"
   
    get '/' do
      
      haml :index
    end
  end
end