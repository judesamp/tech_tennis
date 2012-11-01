# require 'rubygems'
# require 'sinatra'
# require './domain/entities/game'
# require 'json'
# require 'CGI'
# require 'data_mapper'
# require 'dm-validations'
# 
# 
# Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
#   require file
# end
# 
# Dir.glob(File.expand_path("./persistence") +"/*.rb").each do |file|
#   require file
# end

module Implementation
  class Web < Sinatra::Base
    register Mustache::Sinatra
      require './implementation/web/views/web_layout'
      set :public_folder, "implementation/web/public"
      set :view, "implementation/web/templates"
      set :mustache, {
        :views => 'implementation/web/views/',
        :templates => 'implementation/web/templates/'
      }

      
    
    get '/' do      
    
     

      
      mustache :index
    end
    
   
     
    get '/clock' do
       mustache :clock, :layout => false
    end
    
    
    
   end
 end

   
 
   