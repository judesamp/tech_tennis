class Question #this remains a class
  include DataMapper::Resource
  property :id,               Serial
  property :quiz_id,          String
  property :question_id,      String  
  property :question_text,    Text
  property :answer,           String
  property :answer_option_a,  String
  property :answer_option_b,  String
  property :answer_option_c,  String
  property :answer_option_d,  String
  property :last_user_answer, String, :default => "none"
  property :answer_format,    String
  property :times_asked,      Integer, :default => 0
  
  belongs_to :game  
  
  def self.least_asked
    all(:order => [ :times_asked.asc ]).first
  end
  
  
end