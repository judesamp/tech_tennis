require 'rubygems'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'pry'
require 'pry-doc'

module Persistence
  module GameDatum
    include DataMapper::Resource
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
    belongs_to :user_data
    has n, :questions
  end
  
  class Question
    include DataMapper::Resource
    property :id,                             Serial
    belongs_to :game
  end
end

class Game
  include Persistence::GameDatum
  include DataMapper::Resource
end