require 'cgi'

module Domain
  class Game
    include DataMapper::Resource
    #actual fields on the table
    property :id,                             Serial
    property :current_quiz_type,              String, :default => "HTML"
    
    property :current_role,                   String, :default => ["server", "receiver"].sample
    
    property :user_score,                     Integer, :default => 0
    property :user_game,                      String, :default => "0"
    property :user_set,                       Integer, :default => 0
    
    property :opponent_score,                 Integer, :default => 0
    property :opponent_game,                  String,  :default => "0"
    property :opponent_set,                    Integer, :default => 0
    
    property :completed_in,                   Integer, :default => 0
    property :leftover_time,                  Integer, :default => 0
    property :last_result,                    Integer, :default => 0
    property :game_context,                    Integer, :default => 0
    
    #associations with other tables
    #belongs_to :user
    has n, :questions
    
    #"after" hook
    #after :create, :add_default_questions
    
    def add_default_questions
      @processor = QuizContentProcessor.new
      @all_processor_questions = @processor.list
      @all_processor_questions.each do |processor_question|
        question = Domain::Question.create(processor_question)
        question.game = self
        self.questions << question
        self.questions.save
      end
    end
    
    def retrieve_begin_game_data(game_id)
      question = JSON.parse(retrieve_question(game_id).to_json)
      gamedata = begin_game_data
      data_egg = gamedata.merge(question).to_json
    end
    
    def begin_game_data
      {:user_game => "0", :opponent_game => "0", :last_result => 0, :user_set => "0", :opponent_set => "0", :game_context => 0}
    end
    
    def retrieve_continued_game_data(game_id, current_scores, result)
      question = JSON.parse(retrieve_question(game_id).to_json)
      gamedata = continue_game_data(current_scores, result)
      data_egg = gamedata.merge(question).to_json
    end
    
    def continue_game_data(current_scores, result)
      @continued_game_data = {:user_game => current_scores[:user_game], :opponent_game => current_scores[:opponent_game], :user_set => current_scores[:user_set], :opponent_set => current_scores[:opponent_set], :last_result => result, :game_context => current_scores[:game_context]}
    end
    
    
    
    
    def retrieve_question(game_id)
      @current_question = database_first_of_sorted_questions(game_id)
      @current_question[:times_asked] = @current_question[:times_asked] + 1
      @current_question.save
      
      (:a..:d).each do |letter|
        current_symbol = "answer_option_#{letter}".to_sym
        @current_question[current_symbol] = CGI::escapeHTML(@current_question[current_symbol])
      end
      
      @current_question
    end
    
    def escape_HTML(current_answer)
      CGI::escapeHTML(current_answer)
    end
    
    def multiple_choice?(multiple_choice=false)
      multiple_choice
    end
    
    def fill_in_the_blank?(fill_in_the_blank=false)
      fill_in_the_blank
    end
    
    def process_answer_and_score(game_id, question_id, user_answer)
      processed_answer = process_answer(game_id, question_id, user_answer)
      processed_score = process_score(game_id)
      retrieve_continued_game_data(game_id, processed_score, processed_answer)
    end
    
    def process_answer(game_id, question_id, user_answer, elapsed_seconds = 5)
       @get_game = get_game_from_database(game_id)
      @get_all_questions = database_all_questions(game_id)
      @get_current_question = database_get_answered_question(question_id)
      
      if @get_current_question[:answer] == user_answer.chomp
        @get_game[:user_score] = @get_game[:user_score] + 1
        @get_game[:completed_in] = elapsed_seconds
        @get_game[:leftover_time] = @get_game[:leftover_time] + (10 - elapsed_seconds)
        @get_current_question[:last_user_answer] = user_answer
        @get_game[:last_result] = 2

        @get_game.save
        @get_current_question.save
        @get_game[:last_result]
        #what to send back
         
      else
        @get_game[:opponent_score] = @get_game[:opponent_score] + 1
        @get_game[:last_result] = 1
        @get_current_question[:last_user_answer] = user_answer

        @get_game.save
        @get_current_question.save
        @get_game[:last_result]
      end
    end
    
    def process_score(game_id)
      @scores = get_game_from_database(game_id)
      @scores[:game_context] = 0
      @tennis_game_score_hash = { 0 =>"0", 1 => "15", 2 => "30", 3 => "40"}
      @user_points = @scores[:user_score]
      @opponent_points = @scores[:opponent_score]
      @total_points = @user_points + @opponent_points
    
      if @total_points < 6
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
         
           @scores[:user_game] = @tennis_game_score_hash[@user_points]
            @scores[:opponent_game] = end_game_message(false, @scores[:current_role])
            @scores[:game_context] = 1
            @scores[:user_game] = "0"
             @scores[:opponent_set] += 1
            reset_game(game_id, false)
            if endgame(@scores[:user_set], @scores[:opponent_set])
              @scores[:opponent_game] = endgame(@scores[:user_set], @scores[:opponent_set])
              @scores[:game_context] = 2
            end
            @scores
        else
          @scores[:user_game] = @tennis_game_score_hash[@user_points]
          @scores[:opponent_game] = @tennis_game_score_hash[@opponent_points]
          @scores
        end
        
      else
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
    end
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
      @in_progress_game = Domain::Game.first(:id => game_id)
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
  
   def get_game_from_database(game_id)
      Domain::Game.first(:id => game_id)
  end
  
  def database_get_answered_question(question_id)
    @get_all_questions.first(:id => question_id)
  end
end
  #end of database methods
  
  class Question #this remains a class
      include DataMapper::Resource
    property :id,                Serial
    property :quiz_id,          String
    property :question_id,      String  
    property :question,         Text
    property :answer,           String
    property :answer_option_a,   String
    property :answer_option_b,   String
    property :answer_option_c,   String
    property :answer_option_d,   String
    property :last_user_answer, String, :default => "none"
    property :answer_format,    String
    property :times_asked,      Integer, :default => 0
    
    belongs_to :game  
  end
end