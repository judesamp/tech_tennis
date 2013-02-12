class Game
  include DataMapper::Resource
  #actual fields on the table
  property :id,                             Serial
  property :current_quiz_type,              String,   :default => "HTML"
  
  property :current_role,                   String,   :default => ["server", "receiver"].sample
  
  property :user_points,                    Integer,  :default => 0
  property :user_game_score_translation,    String,   :default => "0"
  property :user_set_score,                 Integer,  :default => 0
  
  property :opponent_points,                Integer,  :default => 0
  property :opponent_game_score_translation,String,   :default => "0"
  property :opponent_set_score,                   Integer,  :default => 0
  
  property :completed_in,                   Integer,  :default => 0
  property :leftover_time,                  Integer,  :default => 0
  property :last_result,                    String,   :default => "none"
  property :game_context,                   String,   :default => "none"
  
  #associations with other tables
  #belongs_to :user
  has n, :questions
  
  #and user_score/opponent_score (now user_points/opponent_points); also changed name of opponent_game to opponent_score_translation (etc.)
  
  #"after" hook
  #after :create, :add_default_questions
end