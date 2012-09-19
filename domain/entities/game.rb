require_relative 'question'
require_relative 'player'
require 'json'

module Domain
  class Game
    attr_accessor :player_score, :cpu_score
    
    
    
    def initialize
      @player_score = 0
      @cpu_score = 0
    end
  
    def retrieve_question
      @game = Question.new
      x = rand(1..@game.questions.length - 1)
      @game.questions[x.to_s]
    end
    
    def new_visit?(user_response=true)
        user_response
    end
    
    def multiple_choice?(multiple_choice=false)
      multiple_choice
    end
    
    def fill_in_the_blank?(fill_in_the_blank=false)
      fill_in_the_blank
    end
    
    def process_answer(question_number, user_answer)
      if @game.questions[question_number.to_s][answer] == user_answer
        @player_score =+ 1
      else
        @cpu_score += 1
      end
    end
    def json_test
      {:question => "What in the world?", :answer_a => "sun", :answer_b => "moon", :answer_c => "stars", :answer_d => "grass"}
    end
    
    
    
  end
end

 @game = Domain::Game.new
 @next_question = @game.json_test.to_json
 puts @next_question





