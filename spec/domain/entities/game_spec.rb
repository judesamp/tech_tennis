require_relative '../spec_helper'

module Domain
  describe Game do
    describe "a new Game" do
      before (:each) do
        @game = Game.new
      end
        
      it "score should be 0-0" do
        @game.player_score.should == 0
        @game.cpu_score.should == 0
      end
        
      it "should retrieve a question" do
         @game.retrieve_question.instance_of?(String)
      end
        
        
      it "should accept a response" do
          @game.process_answer.instance_of?(String)
      end
          
          
          
          
          
         
       
      end
    end 
  end

