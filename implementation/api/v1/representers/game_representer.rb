require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Implementation
  module API
    module GameRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
 
      property :current_role
      property :current_quiz_type
      property :user_points
      property :user_game_score_translation
      property :user_set_score
      property :opponent_points
      property :opponent_game_score_translation
      property :opponent_set_score
      property :completed_in
      property :leftover_time
      property :last_result
      property :game_context
    end
                
    module QuestionRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
           
        property :question_id
        property :question_text
        property :answer_option_a
        property :answer_option_b
        property :answer_option_c
        property :answer_option_d
        property :times_asked
        property :user_answer
        property :game_id     
    end
    
    class GameData
      attr_accessor :game, :question
    end
    
    module GameDataRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
        property :game, :class => Game, :extend => GameRepresenter
        property :question, :class => Question, :extend => QuestionRepresenter
    end
  end
end

