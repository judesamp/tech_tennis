class Views
  class Layout < Mustache
     
      
      def new_visit
        @new_visit || false
      end
      
      def multiplechoice
        @multiplechoice || false
      end
      
      def fillintheblank
        @fillintheblank || false
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
  
      class Multiplechoice < Layout
        def question
          @question || "error"
        end

        def answer_a
          @answer_a || "error"
        end

        def answer_b
          @answer_b || "error"
        end

        def answer_c
          @answer_c || "error"
        end

        def answer_d
          @answer_d || "error"
        end
        
        def next_question
          @next_question || "error"
        end
      end
  
  class Greeter < Index
  
  end
  
  class Fillintheblank < Index
  
  end
  
  class Clock < Index
  end
  
end
