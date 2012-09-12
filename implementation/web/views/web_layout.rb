class Views
  class Layout < Mustache
     def question
        @question || " error"
      end
      
      def answer_a
        @answer_a || " error"
      end
      
      def answer_b
        @answer_b || " error"
      end
      
      def answer_c
        @answer_c || " error"
      end
      
      def answer_d
        @answer_d || " error"
      end
      
  end
    
  class Index < Layout 
    def player_score
      @player_score || "0"
    end
      
    def cpu_score
      @cpu_score || "0"
    end
  end
  
  
end
