require 'data_mapper'
require 'dm-postgres-adapter'

DataMapper.setup :default, 'postgres://localhost/tech_tennis'

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
  
  class GameData
    include DataMapper::Resource
    #actual fields on the table
    property :id,                             Serial
    property :current_quiz_type,              String, :default => "HTML"
    property :user_score,                     String, :default => "0"
    property :opponent_score,                 String, :default => "0"
    property :completed_in,                   Integer, :default => 0
    property :leftover_time,                  Integer, :default => 0
    
    #associations with other tables
    belongs_to :user_data
    has n, :questions
    
    #scopes into your data
    #all_questions = Question.all
    #correctly_answered_questions = all_questions(:correct => 1)
    #incorrectly_answered_questions = all_questions(:correct => 2) #Persistence::GameData.incorrectly_answered_questions
   
    # if the above doesn't work try
    #self.correctly_answered_questions = all_questions(:correct => 1)
    #self.all_questions = Questions.all
    # and if THAT doesn't work
    #def self.correctly_answered_questions
    #  all(:correct => 1)
    # end
    
    def self.all_questions(game_id)
      Question.all(:game_data_id => game_id)
    end
    
    def self.this_game_questions
      all_questions(:game_data_id => 209)
    end
    
    
  end

  class Question
      include DataMapper::Resource
    property :id,                Serial
    property :quiz_id,          String
    property :question_id,      String  
    property :question,         Text
    property :answer,           String
    property :answer_options,   Text
    property :last_user_answer, String, :default => "none"
    property :answer_format,    String
    property :times_asked,      Integer, :default => 0
    property :correct,          Integer, :default => 0
  
    belongs_to :game_data
  end
end


  
  
  
 