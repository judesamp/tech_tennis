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
      
 
      
      @questions = {
        
      "1" =>  {
        :quiz_id => "HTML",
        :question_id => "1",
        :last_answer_response => "wrong",
        :question => "What tag would you use to make text bold (opening tag only)?",
        :answer_options => [CGI::escapeHTML("<b>"), CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), "none of the above"],
        :answer_format => "multiple_choice"
      },
      
       "2" =>  {
          :quiz_id => "HTML",
          :question_id => "2",
          :last_answer_response => "wrong",
          :question => "What tag would you use to make text italic (opening tag only)?",
          :answer_options => [CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), CGI::escapeHTML("<b>"), "none of the above"],
          :answer_format => "multiple_choice"
        },
      
      
        "3" =>  {
            :quiz_id => "HTML",
            :question_id => "3",
            :last_answer_response => "wrong",
            :question => "What are the two main divisions in an HTML document?",
            :answer_options => ["top and bottom", "online and offline", "head and content", "head and body"],
            :answer_format => "multiple_choice"
          },
          
          "4" =>  {
              :quiz_id => "HTML",
              :question_id => "4",
              :last_answer_response => "wrong",
              :question => "If CSS formats a page's look. HTML formats a page's ______.",
              :answer_options => ["text", "body", "style", "markup"],
              :answer_format => "multiple_choice"
            },
      
            "5" =>  {
                :quiz_id => "HTML",
                :question_id => "5",
                :last_answer_response => "wrong",
                :question => "What part of an HTML document holds the content?",
                :answer_options => ["body", "head", "page", "face"],
                :answer_format => "multiple_choice"
              },
              "6" =>  {
                  :quiz_id => "HTML",
                  :question_id => "6",
                  :last_answer_response => "wrong",
                  :question => "What tag would you use to create an unordered list (opening tag only)?",
                  :answer_options => [CGI::escapeHTML("<ul>"), CGI::escapeHTML("<li>"), CGI::escapeHTML("<ol>"), CGI::escapeHTML("<un>")],
                  :answer_format => "multiple_choice"
                },
                "7" =>  {
                    :quiz_id => "HTML",
                    :question_id => "7",
                    :last_answer_response => "wrong",
                    :question => "What tag would you use to create or contain a paragraph (opening tag only)?",
                    :answer_options => [CGI::escapeHTML("<p>"), CGI::escapeHTML("<pg>"), CGI::escapeHTML("<b>"), CGI::escapeHTML("<c>")],
                    :answer_format => "multiple_choice"
                  },
                
                  "8" =>  {
                      :quiz_id => "HTML",
                      :question_id => "8",
                      :last_answer_response => "wrong",
                      :question => "What does a closing tag contain that an opening tag does not?",
                      :answer_options => [CGI::escapeHTML("/"), CGI::escapeHTML("<"), CGI::escapeHTML(">"), CGI::escapeHTML("*")],
                      :answer_format => "multiple_choice"
                    }
    } #end of questions
    
      

      
      
  
          
          
          

    
    end
    
   
   
      
  
    
  end
end






    
    
