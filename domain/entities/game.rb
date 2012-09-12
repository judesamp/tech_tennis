require_relative 'question'
require_relative 'player'

module Domain
  class Game
    attr_accessor :player_score, :cpu_score
    
    
    def initialize
      @player_score = 0
      @cpu_score = 0
    end
  
    def retrieve_question
      @game = Question.new
      @game.questions["1"]
    end
    
    def retrieve_answers
      @game.answers["1"]
    end
    
    def process_answer
    end

  end
end

game = Domain::Game.new
puts game.retrieve_question




