module Domain
  class Game
    attr_accessor :greeter
    
    def greeter
      "<h3>Do you want to sign in or play as a guest?</h3>
      <ul id = 'greeting'>
      <li><button onclick='window.open('http://www.espn.com')' type='input'>Sign in</button> </li>
       <li><button type='input'>Play as Guest</button></li>
      </ul>"
    end
    
  end
end

