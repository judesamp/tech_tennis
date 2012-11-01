require_relative 'quizcontentprocessor'
require_relative 'player'

module Domain
  class Game
    attr_accessor :player_score, :cpu_score, :unanswered_questions, :id, :all_questions
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
    
    def initialize  
      @questions = QuizContentProcessor.new
      @all_questions = @questions.list
      
      #### database stuff  #####
      user = Persistence::UserData.create()
      @user_id = user[:id]
      @this_game_data = Persistence::GameData.new()
      @this_game_data.user_data = Persistence::UserData.get(@user_id)
      
      @this_game_data.save
      @game_id = @this_game_data[:id]
      
      @all_questions.each do |question|
        x = Persistence::Question.new(question)
        x.game_data = Persistence::UserData.get(@user_id)
        x.save
      end
      #### database stuff  #####
        
        
        
     
        
      
      
        #connection = Mongo::Connection.new
        #db         = connection.db(DATABASE_NAME)
        #@quiz = db.collection('quiz')
        #@id = @quiz.insert(@unanswered_questions)
      
    end
    
    
    
    def all_questions
      @unanswered_questions.to_a
    end
    
    def retrieve_question
      @all_questions = Persistence::GameData.all_questions(@game_id)
      @current_question = @all_questions[0]
      @current_question
      # break if incoming_data == nil
      #                  else
      #                    processed_answer = process_current_answer(incoming_data)
      #                end
      
    end
    
    def retrieve_game_data
      @this_game_data
    end
        
      
      # process the current answer
      # return response on answer
      # return only question data NEEDED for jQuery (as per the Respresenter)
      # AND it should not be the same key names as anything in @game
      
      
     # @current_question = @unanswered_questions[0]
     # @current_question[:id] = @id
     # remove_current_question
     # #@current_question[:answer_options].map! {|value| CGI::escapeHTML(value)}
     # @current_question.game_id = id
    end
    
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
    
    def process_answer(game_data)
      @submitted_answer = game_data
      correct? ? award_player_point : award_cpu_point
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
    
    def process_score
      process_answer
    end
    
    def game_id
      0
    end
    
    def game_status
      "in progress"
    end
    
  end











