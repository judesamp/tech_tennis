module Domain
  class Question
    attr_accessor :questions, :answers
    
    def initialize
    @questions = {

        "1" => ["What tag would you use to make text bold (opening tag only)?" , 
          [CGI::escapeHTML("<b>"), CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), "none of the above"]],
        "2" => ["What tag would you use to make text italic (opening tag only)?", 
          [CGI::escapeHTML("<i>"), CGI::escapeHTML("<p>"), CGI::escapeHTML("<b>"), "none of the above"]],
        "3" => ["What are the two main divisions in an HTML document?",
          ["top and bottom", "online and offline", "head and content", "head and body"]],
        "4" => ["If CSS formats a page's look. HTML formats a page's ______.",
          ["text", "body", "style", "markup"]],
        "5" => ["What part of an HTML document holds the content?",
          ["body", "head", "page", "face"]],
        "6" => ["What tag would you use to create an unordered list (opening tag only)?", 
          [CGI::escapeHTML("<ul>"), CGI::escapeHTML("<li>"), CGI::escapeHTML("<ol>"), CGI::escapeHTML("<un>")]],
        "7" => ["What tag would you use to create or contain a paragraph (opening tag only)?", 
          [CGI::escapeHTML("<p>"), CGI::escapeHTML("<pg>"), CGI::escapeHTML("<b>"), CGI::escapeHTML("<c>")]],
        "8" => ["What does a closing tag contain that an opening tag does not?", 
          [CGI::escapeHTML("/"), CGI::escapeHTML("<"), CGI::escapeHTML(">"), CGI::escapeHTML("*")]]
      }
    
    end
  end
end





    
    
