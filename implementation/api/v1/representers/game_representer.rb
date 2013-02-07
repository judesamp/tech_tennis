require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Implementation
  module API
    module PlayRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia

      property :id
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
      property :question_id
      property :question_text
      property :answer_option_a
      property :answer_option_b
      property :answer_option_c
      property :answer_option_d
      property :current_quiz_type
      property :times_asked
      property :game_context
      property :user_answer
    end
  end
end

