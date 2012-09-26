module Domain
  class QuizContentProcessor
    attr_accessor :list
    
    def initialize
      #move CGI::escape HTML to web layout?...I think we can run every string through it without harm.
      
      @HTML = [  
       {
      :quiz_id => "HTML",
      :question_id => "1",
      :last_answer_response => "wrong",
      :question => "What tag would you use to make text bold (opening tag only)?",
      :answer => "<b>",
      :answer_options => ["<b>", "<i>", "<p>", "none of the above"],
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "2",
      :last_answer_response => "wrong",
      :question => "What tag would you use to make text italic (opening tag only)?",
      :answer => "<i>",
      :answer_options => ["<i>", "<p>", "<b>", "none of the above"],
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
      :answer_options => ["<ul>", "<li>", "<ol>", "<un>"],
      :answer_format => "multiple_choice"
      },
      {
      :quiz_id => "HTML",
      :question_id => "7",
      :last_answer_response => "wrong",
      :question => "What tag would you use to create or contain a paragraph (opening tag only)?",
      :answer => "<p>",
      :answer_options => ["<pg>", "<b>", "<c>", "<p>"],
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "8",
      :last_answer_response => "wrong",
      :question => "What does a closing tag contain that an opening tag does not?",
      :answer => "/",
      :answer_options => ["<", ">", "/", "*"],
      :answer_format => "multiple_choice"
      }
    ] 
  end
    
   def list
     @HTML.shuffle #a.shuffle(random: Random.new(1
   end
   
      
  
    
  end
end