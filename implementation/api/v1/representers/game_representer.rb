require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Implementation
  module API
    
    class Play
      attr_accessor :id, :question, :answer_option_a, :answer_option_b, :answer_option_c, :answer_option_d, :current_quiz_type, :current_role, :user_score, :user_game, :user_set, :opponent_score, :opponent_game, :opponent_set, :completed_in, :leftover_time, :last_result, :times_asked, :game_id, :game_context
    end
    
    module PlayRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
       property :current_role
        property :user_score
        property :user_game
        property :user_set
        property :opponent_score
        property :opponent_game
        property :opponent_set
        property :completed_in
        property :leftover_time
        property :last_result
        property :id
        property :question
        property :answer_option_a
        property :answer_option_b
        property :answer_option_c
        property :answer_option_d
        property :current_quiz_type
        property :times_asked
        property :game_id
        property :game_context
    end

    
    class Answer
      attr_accessor :id, :question, :answer_option_a, :answer_option_b, :answer_option_c, :answer_option_d, :current_quiz_type, :current_role, :user_score, :user_game, :user_set, :opponent_score, :opponent_game, :opponent_set, :completed_in, :leftover_time, :last_result, :times_asked, :user_answer, :game_id, :game_context    
    end
   

    module AnswerRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
         property :current_role
          property :user_score
          property :user_game
          property :user_set
          property :opponent_score
          property :opponent_game
          property :opponent_set
          property :completed_in
          property :leftover_time
          property :last_result
          property :id
          property :question
          property :answer_option_a
          property :answer_option_b
          property :answer_option_c
          property :answer_option_d
          property :current_quiz_type
          property :times_asked
          property :user_answer
          property :game_id
          property :game_context
    end
  end
end


