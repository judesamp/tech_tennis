require 'roar/representer/json'

module Implementation
  module API
    # class Play
    #   attr_accessor :question_data, :game_data
    # end
    
    module PlayRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
        
        #these go away
        
        property :id
        property :question
        property :answer_option_a
        property :answer_option_b
        property :answer_option_c
        property :answer_option_d
        property :current_quiz_type
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
  
    end
    
    module AnswerRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
        
        # property :id
        # property :answer
  
    end
    
  end
end



