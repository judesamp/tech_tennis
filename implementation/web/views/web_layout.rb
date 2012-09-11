class Views
  class Layout < Mustache
    def greeter
      "boogie?"
    end
      
    def question
      "What in the world?"
    end
  end
    
  class Index < Layout 
    def player_score
      @player_score || "0"
    end
      
    def opponent_score
      @opponent_score || "0"
    end
  end
  
  class Questionbox < Layout
    def question
      @question || "How many moons?"
    end
  end
end
