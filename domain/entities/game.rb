require_relative 'quizcontentprocessor'
require_relative 'player'
require 'json'
require 'digest/sha1'
include ObjectSpace

module Domain
  class Game
    attr_accessor :player_score, :cpu_score, :unanswered_questions, :id
    
    def initialize  
      @id = Digest::SHA1.hexdigest Time.now.to_s
      @player_score = 0
      @cpu_score = 0
      @questions = QuizContentProcessor.new
      @unanswered_questions = @questions.list
      @correctly_answered_questions = []
      @incorrectly_unanswered_questions = []
    end
    
    def self.find_by_id(id)
      found = nil
      ObjectSpace.each_object(Game) { |o|
        found = o if o.id == id
      }
      found
    end
    
    
    def retrieve_question
     @current_question = @unanswered_questions[0]
     @current_question[:id] = @id
     remove_current_question
     @current_question
    end
    
    def remove_current_question 
      @unanswered_questions.shift
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
    
    def process_answer(game_data)
      @submitted_answer = game_data
      correct? ? award_player_point : award_cpu_point
    end
    
    def correct?
      @submitted_answer == @current_question[:answer]
    end
    
    def award_player_point
      @player_score += 1
    end
    
    def award_cpu_point
      @cpu_score += 1
    end
    
    def process_score
      process_answer
    end
    
    def game_id
      0
    end
    
    def game_status
      "in progress"
    end
    
    
  end
end







