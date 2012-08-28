require_relative '../spec_helper'

describe Domain do 
  before(:each) do
    @match = Domain::Game.new
end


  describe "Greeter" do
    it "should send a message greeting user" do
      @match.greeter.should be_an_instance_of(String)
    end
  end
  
  describe "Greeter" do
    it "should accept user to decide if they want to play as guest or create profile" do
      @match.greeter.shoul
    end
  end
      
  
end
