require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Implementation
  module API
      
     class Play
                 attr_accessor :game_id, :current_role, :user_score, :user_game, :user_set, :opponent_score, :opponent_game, :opponent_set, :completed_in, :leftover_time, :last_result, :question_id, :question_text, :answer_option_a, :answer_option_b, :answer_option_c, :answer_option_d, :current_quiz_type, :times_asked, :game_context, :user_answer
          end
    
    module PlayRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia

      property :game_id
                property :current_role
                property :user_points
                property :user_game_score_translation
                property :user_set_score
                property :opponent_points
                property :opponent_game_score_translation
                property :opponent_set_score
                property :completed_in
                property :leftover_time
                property :last_result
                property :question_id
                #property :question_text
                property :answer_option_a
                property :answer_option_b
                property :answer_option_c
                property :answer_option_d
                property :current_quiz_type
                property :times_asked
                property :game_context
                property :user_answer    
    end
    
    class Bowl
      attr_accessor :game
    end
    
    module BowlRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia

      property :game, :class => Play, :extend => PlayRepresenter
    end
  
    
  end
end
    
   #  class Holder
   #       attr_accessor :data
   #     end
   #     
   #     module HolderRepresenter
   #       include Roar::Representer::JSON
   #       include Roar::Representer::Feature::Hypermedia
   #       
   #       property :data, :class => Data, :extend => DataRepresenter
   #     end
   #   end
   # end




    
   #  class GameData
   #       attr_accessor :game, :question
   #     end
   #     
   #     module GameDataRepresenter
   #       include Roar::Representer::JSON
   #       include Roar::Representer::Feature::Hypermedia
   #       
   #         property :game, :class => Game, :extend => GameRepresenter
   #         property :question, :class => Question, :extend => QuestionRepresenter
   #     end
   #   end
   # end

