module Persistence
  class UserData
    include DataMapper::Resource
    
    property :id,                 Serial
    property :user_type,          String, :default => "guest"
    property :history,            Object, :default => []
    property :completed_quizzes,  Object, :default => []
    property :first_name,         String
    property :last_name,          String
    property :email,              String, :format => :email_address
    property :password,           String, :length => 10..255  
    
    has n, :game_data
  end
end