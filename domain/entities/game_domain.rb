require 'cgi'
require_relative 'quizcontentprocessor'
require_relative '../value_objects/questions_persistence'
class Game
  #keep public API class methods up top
  def self.start
    #later, if you need to send data on game start, do it with attributes (sends an empty hash otherwise)
    game = create
    game.add_default_questions
    game.retrieve_begin_game_data
  end
  
  def self.play(attributes)
    #expects :id of the game, :question_id, :user_answer
    game = get(attributes[:game_id])
    game.process_and_save_answer_and_score(attributes)
    #maybe the above method call should not be saving? instead game.save
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
  
  def retrieve_begin_game_data
    question = JSON.parse(retrieve_question.to_json)
    gamedata = begin_game_data
    data_egg = gamedata.merge(question).to_json
  end
  
  def begin_game_data
    {:user_game_score_translation => "0", :opponent_game_score_translation => "0", :last_result => "none", :user_set_score => "0", :opponent_set_score => "0", :game_context => false}
  end
  
  def retrieve_continued_game_data(current_scores, result)
    question = JSON.parse(retrieve_question.to_json)
    gamedata = continue_game_data(current_scores, result)
    data_egg = gamedata.merge(question).to_json
  end
    
  def continue_game_data(current_scores, result)
    continued_game_data = {:user_game_score_translation => self.user_game_score_translation, :opponent_game_score_translation => self.opponent_game_score_translation, :user_set_score => self.user_set_score, :opponent_set_score => self.opponent_set_score, :last_result => self.last_result, :game_context => self.game_context}
  end
  
  def retrieve_question
    current_question = self.questions.least_asked
    increment(current_question, :times_asked)
    escape_html_for_answer(current_question)
  end
  
  
  def escape_html_for_answer(string)
      (:a..:d).each do |letter|
      current_symbol = "answer_option_#{letter}".to_sym
      string[current_symbol] = CGI::escapeHTML(string[current_symbol])
    end
    string
  end
  
  def process_and_save_answer_and_score(attributes)
    processed_answer = process_answer({:question_id => attributes[:question_id], :user_answer => attributes[:user_answer]})
    processed_score = process_score  
    self.save  
    retrieve_continued_game_data(processed_score, processed_answer)
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
    self.attributes = {:game_context => "end_of_point"} # maybe change this value to an understandable string name, but also change the datatype in the DB
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
  if end_of_set?(self.user_set_score, self.opponent_set_score)
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


def process_score_deuce_and_above(attributes)
  if self.user_points == self.opponent_points
    deuce
    
  elsif self.user_points - self.opponent_points == 1
    ad_in
    
  elsif self.user_points - self.opponent_points == 2
    user_wins_game
   
  elsif self.opponent_points - self.user_points == 1
    ad_out
    
  elsif self.opponent_points - self.user_points == 2
    opponent_wins_game
  end
end

def end_of_set?(user_points, opponent_points)
  
   if user_set_score + opponent_set_score > 13
     raise ScoreException, "Something has gone wrong, and you are no longer bound by the rules of tennis! Reload and start a new game!"

   elsif user_set_score == 7 || opponent_set_score == 7

     if user_set_score == 7

           if opponent_set_score == 5
             self.user_game_score_translation = "A late break! You win!"
           else 
             self.user_game_score_translation = "You won in a tiebreaker! Nice job!"
           end

     elsif opponent_set_score == 7
           if user_set_score == 5
             self.opponent_game_score_translation = "A late break for your opponent. You lose!"
           else
             self.opponent_game_score_translation = "You lost in a tiebreaker. Heartbreaking loss!"
           end
     end #end of 7/7

   elsif user_set_score >= 6 || opponent_set_score >= 6

       if user_set_score == 6 

                   if opponent_set_score < 5
                     self.user_game_score_translation = "user wins"
                   elsif opponent_set_score == 5
                     self.user_game_score_translation = "one more and you win"
                   elsif opponent_set_score == 6
                     self.user_game_score_translation = "now to the tiebreaker"
                   elsif opponent_set_score == 7
                     self.user_game_score_translation = "you lost in a tiebreaker...heartbreaking"
                   end

         elsif opponent_set_score == 6

                   if user_set_score < 5
                     self.opponent_game_score_translation = "opponent wins"
                   elsif user_set_score == 5
                     self.opponent_game_score_translation = "one more and opponent wins"
                   elsif user_set_score == 7
                     self.opponent_game_score_translation = "opponent lost in a tiebreaker...exciting"   
                   end
         end #end of 6/6

     else
       false 
     end # end of outer if
 end #end of method
       
  def end_game_message(winner)
    if winner
      if current_role == "receiver"
        ["You broke serve!", "Nice, you won the game!", "MMM. You're getting bad on me.", "Note: Break of Serve."].sample
      else
        ["You held serve!", "Winner!", "No break for you!", "You are on the way!"].sample
      end
    else 
      if current_role == "server"
        ["Winner!", "Held serve!", "Ace. Service winner. Ace. Ace."].sample
      else
        ["Break of serve!", "Winner!", "Uhoh."].sample
      end
    end
  end
  
#database methods below
  def database_get_answered_question(attributes)
    self.questions.first(:question_id => attributes[:question_id])
  end

end