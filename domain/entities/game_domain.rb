require 'cgi'
class Game
  attr_accessor :question
  #keep public API class methods up top
  def self.start
    #later, if you need to send data on game start, do it with attributes (sends an empty hash otherwise)
    game = create
    game.add_default_questions
    question = game.retrieve_question
    game.user_set_score = 5
    game.opponent_set_score = 5
    game.save
    return game, question
  end
  
  def self.play(attributes)
    #expects :id of the game, :question_id, :user_answer
    game = get(attributes[:game_id])
    game.process_and_save_answer_and_score(attributes)
    #maybe the above method call should not be saving? instead game.save
    question = game.retrieve_question
    return game, question
  end
  
  def add_default_questions
    processor = QuizContentProcessor.new
    all_processor_questions = processor.list
    all_processor_questions.each do |processor_question|
      question = Question.create(processor_question)
      question.game = self
      self.questions << question
      self.questions.save
    end
  end
  
  def retrieve_question
    current_question = self.questions.least_asked
    increment(current_question, :times_asked)
    escape_html_for_answer(current_question)
  end
  
  
  def escape_html_for_answer(question)
      (:a..:d).each do |letter|
      current_symbol = "answer_option_#{letter}".to_sym
      question[current_symbol] = CGI::escapeHTML(question[current_symbol])
    end
    question
  end
  
  def process_and_save_answer_and_score(attributes)
    processed_answer = process_answer({:question_id => attributes[:question_id], :user_answer => attributes[:user_answer]})
    processed_score = process_score  
    self.save
  end
  
  def process_answer(attributes)
    get_current_question = database_get_answered_question(attributes)
    get_current_question.last_user_answer = attributes[:user_answer]
    get_current_question.save
    get_current_question.answer == attributes[:user_answer] ? point_to_user : point_to_opponent
    get_current_question
  end
  
  def point_to_user
    increment(self, :user_points)
    self.last_result = "correct"
    self.save
  end
  
  def point_to_opponent
    increment(self, :opponent_points)
    self.last_result = "incorrect"
    self.save
  end
  
  def process_score
    self.attributes = {:game_context => "end_of_point"} 
    total_points_below_six? ? process_score_below_deuce : process_score_deuce_and_above(attributes)
    self
  end

  def total_points_below_six?
     user_points + opponent_points < 6
  end

  def increment(object, value)
     object[value] += 1
     object.save
  end

  def save_attributes_for_user_wins_game
    self.user_game_score_translation = end_game_message(true)
    self.opponent_game_score_translation = "-"
    self.game_context = "end_of_game"
    self.opponent_game_score_translation = "0"
    increment(self, :user_set_score)
  end

  def save_attributes_for_opponent_wins_game
    self.opponent_game_score_translation = end_game_message(false)
    self.user_game_score_translation = "-"
    self.game_context = "end_of_game"
    increment(self, :opponent_set_score)
    self.user_game_score_translation = "0"
  end

  def user_wins_game
    save_attributes_for_user_wins_game
    reset_game
    check_for_end_of_set
    self
  end

  def opponent_wins_game
    save_attributes_for_opponent_wins_game
    reset_game
    check_for_end_of_set
    self
  end

  def check_for_end_of_set
    if end_of_set?
      self.game_context = "end_of_set"
    end
  end

  def process_score_below_deuce
    @tennis_game_score_hash = { 0 => "0", 1 => "15", 2 => "30", 3 => "40"}
    if user_points > 3
      user_wins_game
    elsif @opponent_points > 3
      opponent_wins_game
    else
      self.user_game_score_translation = @tennis_game_score_hash[self.user_points]
      self.opponent_game_score_translation = @tennis_game_score_hash[self.opponent_points]
    end
  end

  def deuce
    self.user_game_score_translation = "Deuce"
    self.opponent_game_score_translation = "Deuce"
  end

  def ad_in
    self.user_game_score_translation = "Ad"
    self.opponent_game_score_translation = "-"
  end

  def ad_out
    self.user_game_score_translation = "-"
    self.opponent_game_score_translation = "Ad"
  end

  def reset_game
    self.user_game_score_translation = "0"
    self.user_points = 0
    self.opponent_game_score_translation = "0"
    self.opponent_points = 0  
  end

  def check_for_end_of_set
    if end_of_set?
      self.game_context = "end_of_set"
    end
  end

  def deuce?
    self.user_points == self.opponent_points
  end

  def ad_in?
    self.user_points - self.opponent_points == 1
  end

  def user_wins_game?
    self.user_points - self.opponent_points == 2
  end

  def ad_out?
    self.opponent_points - self.user_points == 1
  end

  def opponent_wins_game?
    self.opponent_points - self.user_points == 2
  end

  def process_score_deuce_and_above(attributes)
    case
    when deuce?
      deuce
    
    when ad_in?
      ad_in
    
    when user_wins_game?
      user_wins_game
   
    when ad_out?
      ad_out
    
    when opponent_wins_game?
      opponent_wins_game
    end
  end


  def sevens?
    self.user_set_score == 7 || self.opponent_set_score == 7
  end

  def greater_than_or_equal_to_six?
    self.user_set_score >= 6 || self.opponent_set_score >= 6
  end

  def end_of_set?
    case
      when sevens? 
        end_of_set_with_sevens

      when greater_than_or_equal_to_six?
        puts end_of_set_with_sixes
        end_of_set_with_sixes
     
      else
        false 
    end # end of outer if
  end #end of method
 
 
  def user_has_seven
    if self.opponent_set_score == 5
     self.user_game_score_translation = "A late break! You win!"

   else 
     self.user_game_score_translation = "You won in a tiebreaker! Nice job!"

   end
  end

  def opponent_has_seven
    if self.user_set_score == 5
      self.opponent_game_score_translation = "A late break for your opponent. You lose!"

    else
      self.opponent_game_score_translation = "You lost in a tiebreaker. Heartbreaking loss!"

    end
  end
 
 
  def end_of_set_with_sevens
    if self.user_set_score == 7
      user_has_seven
      true

    elsif self.opponent_set_score == 7
      opponent_has_seven
      true
     
    end
  end
 
  def user_has_six
    case
     when self.opponent_set_score < 5
      self.user_game_score_translation = "user wins"
      true
    when self.opponent_set_score == 5
      self.user_game_score_translation = "one more and you win"
      false
    when self.opponent_set_score == 6
      self.user_game_score_translation = "now to the tiebreaker"
      false
    when self.opponent_set_score == 7
      self.user_game_score_translation = "you lost in a tiebreaker...heartbreaking"
      true
    end
  end

  def opponent_has_six
    if self.user_set_score < 5
      self.opponent_game_score_translation = "opponent wins"
      true
    elsif self.user_set_score == 5
      self.opponent_game_score_translation = "one more and opponent wins"
      false
    elsif self.user_set_score == 7
      self.opponent_game_score_translation = "opponent lost in a tiebreaker...exciting"
      true   
    end
  end
 
  def end_of_set_with_sixes
    if self.user_set_score == 6 
      user_has_six
   
    elsif self.opponent_set_score == 6
      opponent_has_six
    
    end #end of 6/6
  end

  def end_game_message(winner)
    case
      when winner
        user_wins_game_message_assignment
        
      else
        opponent_wins_game_message_assignment
    end
  end

  def user_wins_game_message_assignment
    if current_role == "receiver"
      user_breaks_opponents_serve
    else
      user_hold_of_serve
    end
  end

  def opponent_wins_game_message_assignment
    if current_role == "server"
      opponent_breaks_users_serve
    else
      opponent_holds_serve
    end
  end

  def user_hold_of_serve
    ["You held serve!", "Winner!", "No break for you!", "You are on the way!"].sample
  end

  def user_breaks_opponents_serve
    ["You broke serve!", "Nice, you won the game!", "MMM. You're getting bad on me.", "Note: Break of Serve."].sample
  end

  def opponent_hold_of_serve
    ["Winner!", "Held serve!", "Ace. Service winner. Ace. Ace."].sample
  end

  def opponent_break_users_serve
    ["Break of serve!", "Winner!", "Uhoh."].sample
  end
   
  def database_get_answered_question(attributes)
    self.get(attributes[:question_id])
  end
  
end
