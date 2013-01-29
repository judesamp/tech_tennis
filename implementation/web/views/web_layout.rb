class Views
  class Layout < Mustache
    
  end
    
  class Index < Layout 
    def player_score
      @player_score || "0"
    end
      
    def opponent_score
      @cpu_score || "0"
    end
    
    def player_game_score
      @player_game_score || "0"
    end
    
    def opponent_game_score
      @opponent_game_score || "0"
    end
    
    def player_set_score
      @user_set || "0"
    end
    
    def opponent_set_score
      @opponent_set || "0"
    end
    
  end
  
    
   
  
 
  
  
end
