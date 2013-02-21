require_relative '../../spec_helper'
require_relative '../../../domain/entities/game_domain'
require_relative '../../../domain/entities/game_persisitence'

module GameSpecHelper
  def valid_game_attributes
    [{
    :quiz_id => "HTML",
    :question_id => "1",
    :question => "What tag would you use to make text bold (opening tag only)?",
    :answer => "<b>",
    :answer_option_a => "<b>",
    :answer_option_b => "<i>",
    :answer_option_c => "<p>", 
    :answer_option_d => "none of the above",
    :answer_format => "multiple_choice"
    }]
  end
end

describe Domain::Game do
  describe "a new Game before :create hook" do
    include GameSpecHelper
    before (:each) do
      @game = Domain::Game.new(valid_game_attributes)
    end
    
    it "should have a current quiz type" do
      @game.current_quiz_type.should_not be_nil
    end
    
    it "should not yet have an id" do
      @game.id.should be_nil
    end
    
    it "should have a current role" do
     @game.current_role.should == "receiver"
    end
    
    it "should have a user score of 0" do
     @game.user_score.should == 0
    end
    
    it "should have a user game score of '0'" do
     @game.user_game.should == "0"
    end
    
    it "should have a user set score of 0" do
     @game.user_set.should == 0
    end
    
    it "should have a opponent score of 0" do
     @game.opponent_score.should == 0
    end

    it "should have a opponent game score of 0" do
     @game.opponent_game.should == "0"
    end

    it "should have a opponent set score of 0" do
       @game.opponent_set.should == 0
      end


    it "should have a completed in of 0" do
     @game.completed_in.should == 0
    end

    it "should have a leftover time of 0"  do
     @game.leftover_time.should == 0
    end

    it "should have a last result of 0"  do
     @game.last_result.should == 0
    end
    
    it "should not have questions" do
       @game.questions.should be_empty
      end
    
  end
  
  describe "a new Game after :create hook" do
    include GameSpecHelper
    before (:each) do
    end
    
    it "should have two or more questions" do
      
    end
      
      
    it "should be able to retrieve begin game data"
      
      

       
   
  end
end