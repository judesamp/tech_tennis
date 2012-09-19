module Domain
  class Question
    attr_accessor :questions, :answers
    
    def initialize
      
    

   
=begin
        
          {:question_data =>
            
            {  
              :quiz_id =>
              :question_id =>
              :last_answer_response => "wrong",
              :question =>
              :answer_options =>
              :answer_format => ["multiple_choice", "fill_in_the_blank"]
            }
            
            =begin
             {:game_data =>    ,
                { :game_id =>   ,
                  :user_score => [game_score, set_score],
                  :computer_score => [game_score, set_score],
                  :status => ,
                  :wrong_answers => 
                    [
                    {:question_id =>
                    :question =>
                    :user_answer =>
                    :correct_answer =>
                    } 
                    ]
                }
              }

            =end
            
            
           
            
=end
      
=begin   
      
      @questions = {
        
      "1" =>  {
        :quiz_id => "HTML",
        :question_id => "1",
        :last_answer_response => "wrong",
        :question => "What tag would you use to make text bold (opening tag only)?",
        :answer_options => [CGI::escapeHTML("<b>"), CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), "none of the above"],
        :answer_format => "multiple_choice"
      }
    }
=end
      
      
  
          
          
          
      
          
  @questions = {
        "1" => ["What tag would you use to make text bold (opening tag only)?" , 
          [CGI::escapeHTML("<b>"), CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), "none of the above"],[1]],
        "2" => ["What tag would you use to make text italic (opening tag only)?", 
          [CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), CGI::escapeHTML("<b>"), "none of the above"],[2]],
        "3" => ["What are the two main divisions in an HTML document?",
          ["top and bottom", "online and offline", "head and content", "head and body"],[3]],
        "4" => ["If CSS formats a page's look. HTML formats a page's ______.",
          ["text", "body", "style", "markup"],[4]],
        "5" => ["What part of an HTML document holds the content?",
          ["body", "head", "page", "face"],[5]],
        "6" => ["What tag would you use to create an unordered list (opening tag only)?", 
          [CGI::escapeHTML("<ul>"), CGI::escapeHTML("<li>"), CGI::escapeHTML("<ol>"), CGI::escapeHTML("<un>")],[6]],
        "7" => ["What tag would you use to create or contain a paragraph (opening tag only)?", 
          [CGI::escapeHTML("<p>"), CGI::escapeHTML("<pg>"), CGI::escapeHTML("<b>"), CGI::escapeHTML("<c>")],[7]],
        "8" => ["What does a closing tag contain that an opening tag does not?", 
          [CGI::escapeHTML("/"), CGI::escapeHTML("<"), CGI::escapeHTML(">"), CGI::escapeHTML("*")],[8]]
      }

    
    end
    
    def send_random_question
      
    end
   
      
  
    
  end
end






    
    
