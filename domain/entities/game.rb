require_relative 'quizcontentprocessor'
require_relative 'player'
require 'cgi'

module Domain
  class Game
    attr_accessor :player_score, :cpu_score, :unanswered_questions, :id, :all_questions
    attr_writer :answer
    # My expected API for Persistence is:
    # Persistence::GameData is the main api point from a persistence context
    # Persistence::GameData.find(:id)
    # Persistence::GameData.all_questions
    # Persistence::GameData.correct_questions
    # Persistence::GameData.incorrect_questions
    # Persistence::Question.some_method if it makes sense
    
    # probably how we DRY up the code across classes
    # include Persistence::Find
    # include Persistence::Save
    
    def initialize(user_id) 
      Persistence::UserData.create() 
        @game_data = Persistence::GameData.create(:user_data_id => user_id)
        @game_id = @game_data[:id]
         
        @processor = QuizContentProcessor.new
        @all_processor_questions = @processor.list          
        @all_processor_questions.each do |processor_question|
          question = Persistence::Question.create(processor_question)
          @game_data.questions << question
          @game_data.questions.save
        end
      end
    
    def self.find_game(game_id)
      @game = Persistence::GameData.get(game_id)
    end
    
    def all_questions
      @unanswered_questions.to_a
    end
    
    def retrieve_question(game_id = @game_id)
      @all_questions = Persistence::GameData.all_questions(game_id)
      @sorted_questions = @all_questions.all(:order=>[:times_asked.asc])
      @current_question = @sorted_questions.first
      @current_question[:times_asked] = @current_question[:times_asked] + 1
      @current_question.save
      @current_question[:answer_option_a] = CGI::escapeHTML(@current_question[:answer_option_a])
      @current_question[:answer_option_b] = CGI::escapeHTML(@current_question[:answer_option_b])
      @current_question[:answer_option_c] = CGI::escapeHTML(@current_question[:answer_option_c])
      @current_question[:answer_option_d] = CGI::escapeHTML(@current_question[:answer_option_d])
      @current_question
     
      
      #@current_question_data = @all_questions[0]
      
      
      
      # break if incoming_data == nil
      #                  else
      #                    processed_answer = process_current_answer(incoming_data)
      #                end
      
    end
    
    
    
    def retrieve_game_data
      @this_game_data
      puts @this_game_data
    end
        
      
      # process the current answer
      # return response on answer
      # return only question data NEEDED for jQuery (as per the Respresenter)
      # AND it should not be the same key names as anything in @game
      
      
     # @current_question = @unanswered_questions[0]
     # @current_question[:id] = @id
     # remove_current_question
     #@current_question[:answer_options_a] = CGI::escapeHTML(@current_question[:answer_option_a])}
     # @current_question.game_id = id
    
    def update_current_question 
      
    end
    
    def new_visit?(user_response=true)
        user_response
    end
    
    def multiple_choice?(multiple_choice=false)
      multiple_choice
    end
    
    def fill_in_the_blank?(fill_in_the_blank=false)
      fill_in_the_blank
    end
    
    def process_answer(game_id, question_id, user_answer, elapsed_seconds = 5)
      @get_game = Persistence::GameData.first(:id => game_id)
      @get_all_questions = Persistence::GameData.all_questions(game_id)
      @get_current_question = @get_all_questions.first(:id => question_id)
      
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
        puts "nope!"
        @get_game[:opponent_score] = @get_game[:opponent_score] + 1
        @get_game[:last_result] = 1
        @get_current_question[:last_user_answer] = user_answer
        
        
        @get_game.save
        @get_current_question.save
        #process_score(game_id)
        @get_game[:last_result]
      end
     #puts game_id
     #puts user_answer 
     #@submitted_answer = game_data
      #
      #correct? ? award_player_point : award_cpu_point
    end
    
    def process_score(game_id)
      @scores = Persistence::GameData.first(:id => game_id)
      @tennis_game_one = {0 =>"0", 1 => "15", 2 => "30", 3 => "40"}
      @user_points = @scores[:user_score]
      @opponent_points = @scores[:opponent_score]
      @total_points = @user_points + @opponent_points
      # print "User: "
      #       puts @user_points 
      #       print "CPU: "
      #       puts @opponent_points
      #       
      if @total_points < 6
        if @user_points > 3
          @scores[:user_game] = end_game_message(true, @scores[:current_role])
          @scores[:opponent_game] = @tennis_game_one[@opponent_points]
          reset_game(game_id)
          @scores
        elsif @opponent_points > 3
         
           @scores[:user_game] = @tennis_game_one[@user_points]
            @scores[:opponent_game] = end_game_message(false, @scores[:current_role])
            reset_game(game_id)
            @scores
        else
          @scores[:user_game] = @tennis_game_one[@user_points]
          @scores[:opponent_game] = @tennis_game_one[@opponent_points]
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
          @scores[:opponent_game] = "-"
          reset_game(game_id)
          @scores
        elsif @opponent_points - @user_points == 1
          @scores[:user_game] = "-"
          @scores[:opponent_game] = "Ad"
          @scores
        elsif @opponent_points - @user_points == 2
          
          @scores[:user_game] = "-"
          @scores[:opponent_game] = end_game_message(false, @scores[:current_role])
          reset_game(game_id)
          @scores
        
      end
    end
  end
         
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
    
    def reset_game(game_id)
      #reset to 0 or "0"---- user_game, user_score, opponent_game, opponent_score
      #different method? change user_set, change opponent_set
      @in_progress_game = Persistence::GameData.first(:id => game_id)
        @in_progress_game[:user_game] = "0"
        @in_progress_game[:user_score] = 0
        @in_progress_game[:opponent_game] = "0"
        @in_progress_game[:opponent_score] = 0
      @in_progress_game.save
      
    end
    
         
    def correct?
      @submitted_answer == @current_question[:answer]
    end
    
    def award_player_point
      @player_score += 1
    end
    
    def award_cpu_point
      @cpu_score += 1
    end
 
    
    def game_id
      0
    end
    
    def game_status
      "in progress"
    end
    
  end
end
  








