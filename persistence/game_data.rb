

module Persistence
    class Quiz
    include DataMapper::Resource

    property :id,               Serial
    property :quiz_id,          String
    
    has n, :questions
    ##has n :answeroptions, :through => :questions
    
    end

  class Question
      include DataMapper::Resource
    
    property :id,               Serial
    property :quiz_id,          String
    property :question_id,      String  
    property :question,         Text
    property :answer,           String
    property :answer_options,   Object
    property :last_user_answer, String, :default => "none"
    property :answer_format,    String
    property :times_asked,      Integer, :default => 0
    property :correct?,         Boolean,  :default => false
  
    belongs_to :quiz
    #has n, :answeroptions
  end
  
  #class Answeroption
   # include DataMapper::Resource
    
    #property :id,               Serial
    #property :answer_options,   Text
    
    #belongs_to :question
  #end
end
  
  
  
 