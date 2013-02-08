
  class QuizContentProcessor
    attr_accessor :list
    
    def initialize
      #move CGI::escape HTML to web layout?...I think we can run every string through it without harm.
      
      @HTML = [  
       {
      :quiz_id => "HTML",
      :question_id => "1",
      :question => "What tag would you use to make text bold (opening tag only)?",
      :answer => "<b>",
      :answer_option_a => "<b>",
      :answer_option_b => "<i>",
      :answer_option_c => "<p>", 
      :answer_option_d => "none of the above",
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "2",
      :question => "What tag would you use to make text italic (opening tag only)?",
      :answer => "<i>",
      :answer_option_a => "<i>",
      :answer_option_b => "<p>",
      :answer_option_c => "<b>",
      :answer_option_d => "none of the above",
      :answer_format => "multiple_choice"
      },


      {
      :quiz_id => "HTML",
      :question_id => "3",
      :question => "What are the two main divisions in an HTML document?",
      :answer => "head and body",
       :answer_option_a => "top and bottom",
        :answer_option_b => "online and offline", 
        :answer_option_c => "head and content",
        :answer_option_d => "head and body",
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "4",
      :question => "If CSS formats a page's look. HTML formats a page's ______.",
      :answer => "text",
       :answer_option_a => "text",
        :answer_option_b => "body", 
        :answer_option_c => "style",
        :answer_option_d => "markup",
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "5",
      :question => "What part of an HTML document holds the content?",
      :answer => "body",
       :answer_option_a => "head",
        :answer_option_b => "page", 
        :answer_option_c => "body",
        :answer_option_d => "face",
      :answer_format => "multiple_choice"
      },
      {
      :quiz_id => "HTML",
      :question_id => "6",
      :question => "What tag would you use to create an unordered list (opening tag only)?",
      :answer => "<ul>",
       :answer_option_a => "<ul>",
        :answer_option_b => "<li>",
        :answer_option_c => "<ol>",
        :answer_option_d => "<un>",
      :answer_format => "multiple_choice"
      },
      {
      :quiz_id => "HTML",
      :question_id => "7",
      :question => "What tag would you use to create or contain a paragraph (opening tag only)?",
      :answer => "<p>",
       :answer_option_a => "<pg>",
        :answer_option_b => "<b>",
        :answer_option_c => "<c>",
        :answer_option_d => "<p>",
      :answer_format => "multiple_choice"
      },

      {
      :quiz_id => "HTML",
      :question_id => "8",
      :question => "What does a closing tag contain that an opening tag does not?",
      :answer => "/",
      :answer_option_a => "<",
      :answer_option_b => ">",
      :answer_option_c => "/",
      :answer_option_d => "*",
      :answer_format => "multiple_choice"
      }
    ] 
  end
    
   def list
     @HTML.shuffle #a.shuffle(random: Random.new(1
   end
   
      
  
    
  end