require 'roar/representer/json'

module Implementation
  module API
    class Play
      attr_accessor :question_data, :game_data
    end
    
    module PlayRepresenter
      include Roar::Representer::JSON
      include Roar::Representer::Feature::Hypermedia
      
        property :question_data
        property :game_data
  
    end
    
    
  end
end



