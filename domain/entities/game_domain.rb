require 'cgi'
require_relative 'quizcontentprocessor'
require_relative '../value_objects/questions_persistence'
class Game
  #keep public API class methods up top
  def self.start
    #later, if you need to send data on game start, do it with attributes (sends an empty hash otherwise)
    game = create
    game.add_default_questions
    game
  end
  
  def self.play(attributes)
    #expects :id of the game, :question_id, :user_answer
    game = get(attributes[:id])
    game.process_answer_and_score(attributes)
    #maybe the above method call should not be saving? instead game.save
    game
  end
  
  def add_default_questions
    @processor = QuizContentProcessor.new
    @all_processor_questions = @processor.list
    @all_processor_questions.each do |processor_question|
      question = Question.create(processor_question)
      question.game = self
      self.questions << question
      self.questions.save
    end
  end
  
  # def retrieve_begin_game_data
  #    question = JSON.parse(retrieve_question.to_json)
  #    gamedata = begin_game_data
  #    data_egg = gamedata.merge(question).to_json
  #  end
  
  # def begin_game_data
  #     {:user_game => "0", :opponent_game => "0", :last_result => 0, :user_set => "0", :opponent_set => "0", :game_context => 0}
  #   end
  
  # def retrieve_continued_game_data(game_id, current_scores, result)
  #   question = JSON.parse(retrieve_question(game_id).to_json)
  #   gamedata = continue_game_data(current_scores, result)
  #   data_egg = gamedata.merge(question).to_json
  # end
  
  # def continue_game_data(current_scores, result)
  #   continued_game_data = {:user_game => current_scores[:user_game], :opponent_game => current_scores[:opponent_game], :user_set => current_scores[:user_set], :opponent_set => current_scores[:opponent_set], :last_result => result, :game_context => current_scores[:game_context]}
  # end
  
  def retrieve_question
    #Split into atomic methods
    current_question = self.questions.least_asked
    current_question[:times_asked] = current_question[:times_asked] + 1
    current_question.save
    current_question = escape_html_for_answer(current_question)
    current_question
  end
  
  def escape_html_for_answer(string)
      (:a..:d).each do |letter|
      current_symbol = "answer_option_#{letter}".to_sym
      string[current_symbol] = CGI::escapeHTML(string[current_symbol])
    end
    string
  end
  
  def process_answer_and_score(question_id, user_answer)
    processed_answer = process_answer(id, question_id, user_answer)
    retrieve_continued_game_data(id, processed_score, processed_answer)
  end
  
  def process_answer(question_id, user_answer, elapsed_seconds = 5)
    #@get_game = get_game_from_database(game_id)
    @get_current_question = database_get_answered_question(question_id)
    
    @get_current_question[:answer] == user_answer ? point_to_user : point_to_opponent
    process_score
  end
  
  def point_to_user
    @get_game[:user_score] = @get_game[:user_score] + 1
    @get_game[:completed_in] = elapsed_seconds
    @get_game[:leftover_time] = @get_game[:leftover_time] + (10 - elapsed_seconds)
    @get_current_question[:last_user_answer] = user_answer
    @get_game[:last_result] = 2 # "correct";  0 = "unanswered"

    @get_game.save
    @get_current_question.save
    @get_game[:last_result]
  end
  
  def point_to_opponent
    @get_game[:opponent_score] = @get_game[:opponent_score] + 1
    @get_game[:last_result] = 1 #"incorrect"
    @get_current_question[:last_user_answer] = user_answer

    @get_game.save
    @get_current_question.save
    @get_game[:last_result]
  end
  
  def process_score
    self.attributes = {:game_context => 0} # maybe change this value to an understandable string name, but also change the datatype in the DB
    self.save
    total_points = user_points + opponent_points
    total_points_below_six? ? process_score_below_deuce(attributes) : process_score_deuce_and_above(attributes)
  end
end

def total_points_below_six?
  total_points < 6
end

def increment
  
end

def process_score_below_deuce(attributes)
  @tennis_game_score_hash = { 0 => "0", 1 => "15", 2 => "30", 3 => "40"}
  if @user_points > 3
    @scores[:user_game] = end_game_message(true, @scores[:current_role])
    @scores[:game_context] = 1
    
    @scores[:user_set] += 1
    @scores[:opponent_game] = "0"
    reset_game(game_id, true)
    if endgame(@scores[:user_set], @scores[:opponent_set])
      @scores[:user_game] = endgame(@scores[:user_set], @scores[:opponent_set])
      @scores[:game_context] = 2
    end
      
    @scores
  elsif @opponent_points > 3
   attributes = {
     :user_game => @tennis_game_score_hash[@user_points],
     :opponent_game => end_game_message(false, @scores[:current_role]),
     :game_context => 1,
     :user_game => "0",
     :opponent_set => self.opponent_set += 1,
     }
     self.attributes(attributes)
     self.save
      reset_game(game_id, false)
      if endgame(@scores[:user_set], @scores[:opponent_set])
        @scores[:opponent_game] = endgame(@scores[:user_set], @scores[:opponent_set])
        @scores[:game_context] = 2
      end
      self.attributes(attributes)
      self.save
  # else
  #   @scores[:user_game] = @tennis_game_score_hash[@user_points]
  #   @scores[:opponent_game] = @tennis_game_score_hash[@opponent_points]
  #   @scores
  end
end

def process_score_deuce_and_above(attributes)
  if @user_points == @opponent_points
    @scores[:user_game] = "Deuce"
    @scores[:opponent_game] = "Deuce"
    @scores
  elsif @user_points - @opponent_points == 1
    @scores[:user_game] = "Ad"
    @scores[:opponent_game] = "-"
    @scores
  elsif @user_points - @opponent_points == 2
    
    @scores[:user_game] = end_game_message(true, @scores[:current_role])
    @scores[:game_context] = 1
    @scores[:user_set] += 1
    @scores[:opponent_game] = "0"
    reset_game(game_id, true)
    if endgame(@scores[:user_set], @scores[:opponent_set])
      @scores[:user_game] = endgame(@scores[:user_set], @scores[:opponent_set])
      @scores[:game_context] = 2
    end
    @scores
  elsif @opponent_points - @user_points == 1
    @scores[:user_game] = "-"
    @scores[:opponent_game] = "Ad"
    @scores
  elsif @opponent_points - @user_points == 2
    
    @scores[:user_game] = "-"
    @scores[:opponent_game] = end_game_message(false, @scores[:current_role])
    @scores[:game_context] = 1
    if endgame(@scores[:user_set], @scores[:opponent_set])
      @scores[:opponent_game] = endgame(@scores[:user_set], @scores[:opponent_set])
      @scores[:game_context] = 2
    end
    @scores[:user_game] = "0"
    @scores[:opponent_set] += 1
    
    reset_game(game_id, false)
    @scores
end

def endgame(user_score, opponent_score)
  
   if user_score + opponent_score > 13
     raise ScoreException, "Something has gone wrong, and you are no longer bound by the rules of tennis! Reload and start a new game!"

   elsif user_score == 7 || opponent_score == 7

     if user_score == 7

           if opponent_score == 5
             "A late break! You win!"
           else 
             "You won in a tiebreaker! Nice job!"
           end

     elsif opponent_score == 7
           if user_score == 5
             "A late break for your opponent. You lose!"
           else
             "You lost in a tiebreaker. Heartbreaking loss!"
           end
     end #end of 7/7

   elsif user_score >= 6 || opponent_score >= 6

       if user_score == 6 

                   if opponent_score < 5
                     "user wins"
                   elsif opponent_score == 5
                     "one more and you win"
                   elsif opponent_score == 6
                     "now to the tiebreaker"
                   elsif opponent_score == 7
                     "you lost in a tiebreaker...heartbreaking"
                   end

         elsif opponent_score == 6

                   if user_score < 5
                     "opponent wins"
                   elsif user_score == 5
                     "one more and opponent wins"
                   elsif user_score == 7
                     "opponent lost in a tiebreaker...exciting"   
                   end
         end #end of 6/6

     else
       false 
     end # end of outer if
 end #end of method
       
  def end_game_message(winner, current_role)
    if winner
      if current_role == "receiver"
        ["You broke serve!", "Nice, you won the game!", "MMM. You're getting bad on me.", "Note: Break of Serve."].sample
      else
        ["You held serve!", "Winner!", "No break for you!", "You are on the way!"].sample
      end
    else 
      if current_role == "receiver"
        ["Winner!", "Held serve!", "Ace. Service winner. Ace. Ace."].sample
      else
        ["Break of serve!", "Winner!", "Uhoh."].sample
      end
    end
  end
  
  def reset_game(game_id, winner)
    #reset to 0 or "0"---- user_game, user_score, opponent_game, opponent_score
    #different method? change user_set, change opponent_set
    @in_progress_game = get_game_from_database(game_id)
      @in_progress_game[:user_game] = "0"
      @in_progress_game[:user_score] = 0
      @in_progress_game[:opponent_game] = "0"
      @in_progress_game[:opponent_score] = 0
        if winner
        @in_progress_game[:user_set] += 1
        else
        @in_progress_game[:opponent_set] += 1
        end
    @in_progress_game.save  
  end
  
#database methods below
def database_all_questions(game_id)
  Domain::Question.all(:game_id => game_id)
end

def database_sort_all_questions(game_id)
  all_database_questions = Domain::Question.all(:game_id => game_id)
  sorted_database_questions = all_database_questions.all(:order=>[:times_asked.asc])
end

def database_first_of_sorted_questions(game_id)
  all_database_questions = Domain::Question.all(:game_id => game_id)
  sorted_database_questions = all_database_questions.all(:order=>[:times_asked.asc])
  first_of_sorted_questions = sorted_database_questions.first
end


def database_get_answered_question(question_id)
  @get_all_questions.first(:id => question_id)
end

def self.database_save(object)
  object.save
end

end