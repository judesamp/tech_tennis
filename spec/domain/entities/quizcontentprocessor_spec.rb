require_relative '../../spec_helper'

  describe Domain::QuizContentProcessor do
  
    describe "a new quiz content processor" do
      it "should respond to the list method" do
        questions = Domain::QuizContentProcessor.new
        questions.should respond_to(:list)
      end
      
      it "should respond to the list method and return an array" do
          questions = Domain::QuizContentProcessor.new
          questions.list.should be_instance_of(Array)
      end
      
       it "should respond to the list method and return an array with more than one question" do
            questions = Domain::QuizContentProcessor.new
            questions.list.length.should >= 2
        end
      
    end
  end