module Domain
  class Question
    attr_accessor :questions, :answers
    
    def initialize
    @questions = {

        "1" => ["What tag would you use to make text bold (opening tag only)?" , 
          ["<b>", "<i>", "<p>", "none of the above"]],
        "2" => ["What tag would you use to make text italic (opening tag only)?", 
          ["<i>", "<p>", "<b>", "none of the above"]],
        "3" => ["What are the two main divisions in an HTML document?",
          ["top and bottom", "online and offline", "head and content", "head and body"]],
        "4" => ["If CSS formats a page's look. HTML formats a page's ______.",
          ["text", "body", "style", "markup"]],
        "5" => ["What part of an HTML document holds the content?",
          ["body", "head", "page", "face"]],
        "6" => ["What tag would you use to create an unordered list (opening tag only)?", 
          ["<ul>", "<li>", "<ol>", "<un>"]],
        "7" => ["What tag would you use to create or contain a paragraph (opening tag only)?", 
          ["<p>", "<pg>", "<b>", "<c>"]],
        "8" => ["What does a closing tag contain that an opening tag does not?", ["/", "<", ">", "*"]]
      }
    
    end
  end
end





    
    
