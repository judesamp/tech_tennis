module Domain
  class Question
    attr_accessor :questions, :answers
    
    def initialize
    @questions = {

        "1" => "What tag would you use to make text bold (opening tag only)?" ,
        "2" => "What tag would you use to make text italic (opening tag only)?",
        "3" => "What are the two main divisions in an HTML document?",
        "4" => "If CSS formats a page's look. HTML formats a page's ______.", 
        "5" => "What part of an HTML document holds the content?",
        "6" => "What tag would you use to create an unordered list (opening tag only)?", 
        "7" => "What tag would you use to create or contain a paragraph (opening tag only)?", 
        "8" => "What does a closing tag contain that an opening tag does not?"
      }
    
    @answers = {
      "1" => ["<b>", "<i>", "<p>", "none of the above"],
      "2" => ["<i>", "<p>", "<b>", "none of the above"],
      "3" => ["top and bottom", "online and offline", "head and content", "head and body"],
      "4" => ["text", "body", "style", "markup"],
      "5" => ["body", "head", "page", "face"],
      "6" => ["<ul>", "<li>", "<ol>", "<un>"],
      "7" => ["<p>", "<pg>", "<b>", "<c>"],
      "8" => ["/", "<", ">", "*"]
      }
    end
  end
  end





    
    
