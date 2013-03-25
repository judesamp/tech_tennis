module Implementation
  class Ember < Sinatra::Base
    set :public_folder, "implementation/ember/public"
    set :views, "implementation/ember/views"
    
    get '/' do
      
      erb :index
    end
  end
end

 

