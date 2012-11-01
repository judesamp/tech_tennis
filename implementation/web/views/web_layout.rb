require 'CGI'

class Views
  class Layout < Mustache
    
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
