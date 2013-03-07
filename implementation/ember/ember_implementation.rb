module Implementation
  class Web < Sinatra::Base
    set :public_folder, "implementation/ember/public"
    set :view, "implementation/web/templates"
    
    get '/' do      
      erb :index
    end
  end
end

 

