require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'persistence/game_data.rb'
require_relative 'persistence/user_data.rb'

DataMapper.setup :default, 'postgres://localhost/tech_tennis'
DataMapper.auto_upgrade!

module Persistence
	module User
		include DataMapper::Resource
		
		property :id,			  Serial
		property :name,			String
		property :gender,		String
		property :email, 		String, :format => :email_address
		
	  
	  
  end
end
  
  


##insert documents into database




class UserStuff
  include DataMapper::Resource
  
  puts UserStuff.methods
  
  
  
 
  
  
  
end

x = UserStuff.new
puts "x.methods:  #{x.methods}"
puts "x.methods(false):  #{x.methods(false)}"


puts "y.methods:  #{UserStuff.methods}"
puts "y.methods(false):  #{UserStuff.methods(false)}"










		