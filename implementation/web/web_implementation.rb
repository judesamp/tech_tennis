require 'rubygems'
require 'sinatra'
require './domain/entities/game'
require 'Haml'

Dir.glob(File.expand_path("./implementation/web/routes") +"/*_routes.rb").each do |file|
  require file
end

module Implementation
  class Web < Sinatra::Base
    register Mustache::Sinatra
      require './implementation/web/views/web_layout'
      set :public, "implementation/web/public"
      set :view, "implementation/web/templates"
      set :mustache, {
        :views => 'implementation/web/views',
        :templates => 'implementation/web/templates'
      }

      
    
    get '/' do
      @game = Domain::Game.new
      haml :index
      
    end
  end
end
   