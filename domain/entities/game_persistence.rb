class Game
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
  property :opponent_set,                   Integer, :default => 0
  
  property :completed_in,                   Integer, :default => 0
  property :leftover_time,                  Integer, :default => 0
  property :last_result,                    Integer, :default => 0
  property :game_context,                   Integer, :default => 0
  
  #associations with other tables
  #belongs_to :user
  has n, :questions
  
  #"after" hook
  #after :create, :add_default_questions
end