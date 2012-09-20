module Domain
  class Question
    attr_accessor :list
    
    def initialize
      @questions = [  
       {
      :quiz_id => "HTML",
      :question_id => "1",
      :last_answer_response => "wrong",
      :question => "What tag would you use to make text bold (opening tag only)?",
      :answer => "a",
      :answer_options => [CGI::escapeHTML("<b>"), CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), "none of the above"],
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "2",
      :last_answer_response => "wrong",
      :question => "What tag would you use to make text italic (opening tag only)?",
      :answer => "a",
      :answer_options => [CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), CGI::escapeHTML("<b>"), "none of the above"],
      :answer_format => "multiple_choice"
      },


      {
      :quiz_id => "HTML",
      :question_id => "3",
      :last_answer_response => "wrong",
      :question => "What are the two main divisions in an HTML document?",
      :answer => "head and body",
      :answer_options => ["top and bottom", "online and offline", "head and content", "head and body"],
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "4",
      :last_answer_response => "wrong",
      :question => "If CSS formats a page's look. HTML formats a page's ______.",
      :answer => "text",
      :answer_options => ["text", "body", "style", "markup"],
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "5",
      :last_answer_response => "wrong",
      :question => "What part of an HTML document holds the content?",
      :answer => "body",
      :answer_options => ["head", "page", "body", "face"],
      :answer_format => "multiple_choice"
      },
      {
      :quiz_id => "HTML",
      :question_id => "6",
      :last_answer_response => "wrong",
      :question => "What tag would you use to create an unordered list (opening tag only)?",
      :answer => "<ul>",
      :answer_options => [CGI::escapeHTML("<ul>"), CGI::escapeHTML("<li>"), CGI::escapeHTML("<ol>"), CGI::escapeHTML("<un>")],
      :answer_format => "multiple_choice"
      },
      {
      :quiz_id => "HTML",
      :question_id => "7",
      :last_answer_response => "wrong",
      :question => "What tag would you use to create or contain a paragraph (opening tag only)?",
      :answer => "<p>",
      :answer_options => [CGI::escapeHTML("<pg>"), CGI::escapeHTML("<b>"), CGI::escapeHTML("<c>"), CGI::escapeHTML("<p>")],
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "8",
      :last_answer_response => "wrong",
      :question => "What does a closing tag contain that an opening tag does not?",
      :answer => "/",
      :answer_options => [CGI::escapeHTML("<"), CGI::escapeHTML(">"), CGI::escapeHTML("/"), CGI::escapeHTML("*")],
      :answer_format => "multiple_choice"
      }
    ] #end of questions
    end
    
   def list
     @questions.shuffle #a.shuffle(random: Random.new(1))
   end
   
      
  
    
  end
end






    
    
