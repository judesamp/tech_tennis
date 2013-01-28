require 'rubygems'
require 'sinatra'
require './domain/entities/game'
require 'haml'

Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
  require file
end

module Implementation
  class Web < Sinatra::Base
    require './implementation/web/views/web_layout'
    set :views, "implementation/web/templates"
    set :public_folder, "implementation/web/public"
    
    get '/mobile' do
      "This is the index which loads Sencha Touch"
      # Replace above with:
      # haml :mobile_index
      # which will load the Sencha Touch framwork app
    end
  end
end
