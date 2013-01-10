require 'data_mapper'
require 'dm-postgres-adapter'

module Persistence
  module GameDatum #this becomes a module which is included in Domain::Game
    include DataMapper::Resource
    #actual fields on the table
    property :id,                             Serial
    property :current_quiz_type,              String, :default => "HTML"
    
    property :current_role,                   String, :default => ["server", "receiver"].sample
    
    property :user_score,                     Integer, :default => 0
    property :user_game,                      String, :default => "0"
    property :user_set,                       Integer, :default => 0
    
    property :opponent_score,                 Integer, :default => 0
    property :opponent_game,                  String,  :default => "0"
    property :opponent_set,                    Integer, :default => 0
    
    property :completed_in,                   Integer, :default => 0
    property :leftover_time,                  Integer, :default => 0
    property :last_result,                    Integer, :default => 0
    
    #associations with other tables
    belongs_to :user_data
    has n, :questions
    
    module ClassMethods
      include DataMapper::Resource
      property :id,                             Serial
    end
    
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    
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
  
    def self.sorted_by_times_asked
      all_questions(:order => [:times_asked.asc])
    end
    
    def self.current_question
      sorted_by_times_asked.first
    end
    
    def self.find(game_id)
      GameDatum.all(:id => game_id)
    end
    
    

    

    
       
    end
    
     
  
    #THIS WILL BE FOR THE EXTEND PORTION OF THE Domain::Game
    
    
  
     
     
    
  class Question #this remains a class
      include DataMapper::Resource
    property :id,                Serial
    property :quiz_id,          String
    property :question_id,      String  
    property :question,         Text
    property :answer,           String
    property :answer_option_a,   String
    property :answer_option_b,   String
    property :answer_option_c,   String
    property :answer_option_d,   String
    property :last_user_answer, String, :default => "none"
    property :answer_format,    String
    property :times_asked,      Integer, :default => 0
    
  
    belongs_to :game_datum
    
    def self.times_asked_increment(question_id)
      question = Question.first(:question_id => question_id)
      question[:times_asked] = question[:times_asked] + 1
      question.save
    end
    
  end

end


  
  
  
 