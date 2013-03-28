class Views
  class Layout < Mustache
    
  end
    
  class Scoreboard < Layout 
    def player_score
      @player_score || "0"
    end
      
    def opponent_score
      @cpu_score || "0"
    end
    
    def user_game_score_translation
      @user_game_score_translation || "0"
    end
    
    def opponent_game_score_translation
      @opponent_game_score_translation || "0"
    end
    
    def user_set_score
      @user_set_score || "0"
    end
    
    def opponent_set_score
      @opponent_set_score || "0"
    end
    
    def current_quiz_type
      @current_quiz_type || "HTML"
    end
    
  end
  
    
   
  
 
  
  
end
