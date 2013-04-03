require_relative '../../spec_helper'
require_relative '../../../domain/entities/game_domain'
require_relative '../../../domain/entities/game_persistence'
require_relative '../../../domain/entities/quizcontentprocessor'
require_relative '../../../domain/value_objects/questions_persistence'



describe "Game" do
  let(:game) {Game.start}
  let(:game_data) {game[0]}
  let(:question_data) {game[1]}
  
  let(:correct_answer) { {  :id => game_data.id, 
                            :question_id =>question_data.id,
                            :user_answer =>question_data.answer} }
                            
  
  let(:incorrect_answer) { { :id => game_data.id, 
                             :question_id => question_data.id,
                             :user_answer => "incorrect answer" } }
                             
  describe "Game.start" do
    it "has a current quiz type" do
      expect(game_data.current_quiz_type).to eq "HTML"
    end
    
    it "has a current role" do
      expect(game_data.current_role).to be_instance_of(String)
    end
    
    it "has user_points" do
      expect(game_data.user_points).to eq 0
    end
    
    it "has a user game score translation" do
      expect(game_data.user_game_score_translation).to eq "0"
    end
    
    it "has a user set score" do
      expect(game_data.user_set_score).to eq 4
    end
    
    it "has opponent_points" do
      expect(game_data.opponent_points).to eq 0
    end

    it "has an opponent game score translation" do
      expect(game_data.opponent_game_score_translation).to eq "0"
    end

    it "has an opponent set score" do
      expect(game_data.opponent_set_score).to eq 4
    end
    
    it "has a last result of none" do
       expect(game_data.last_result).to eq "none"
    end
    
    it "has a game context" do
       expect(game_data.game_context).to eq "false"
    end
  end #end Game.start
  
  describe "Game.play" do    
    context "after a correct answer" do
                                                  
      let(:game_with_correct_answer) {Game.play(correct_answer)}
      
      it "assigns a point to user" do
        expect(game_with_correct_answer[0][:user_points]).to eq 1
      end
    
      it "translates point tally into tennis score" do
        
        expect(game_with_correct_answer[0][:user_game_score_translation]).to eq "15"
      end
    
      it "retrieves the second question (not the same as the first)" do
        expect(game_with_correct_answer[1][:question_id]).to_not eq question_data.question_id 
      end
    end
    
   context "for an incorrect answer"
                       
      let(:game_with_incorrect_answer) {Game.play(incorrect_answer)}

      it "assigns a point to opponent" do
        expect(game_with_incorrect_answer[0][:opponent_points]).to eq 1
        expect(game_with_incorrect_answer[0][:user_points]).to eq 0
      end

      it "translates point tally into tennis score" do
        expect(game_with_incorrect_answer[0][:opponent_game_score_translation]).to eq "15"
      end

      it "retrieves the second question (not the same as the first)" do
        expect(game_with_incorrect_answer[1][:question_id]).to_not eq question_data.question_id 
      end
    end
 

    
  describe "scoring" do
       let(:game_with_correct_answer) {Game.play(correct_answer)}
        let(:game_with_incorrect_answer) {Game.play(incorrect_answer)}
        
        let(:lost_first_point) {game_with_incorrect_answer[0]}
        
    describe "game scoring" do  
      describe "user wins first point" do
        let(:won_first_point) {game_with_correct_answer[0]}
       
        it "returns a score of 15 for user" do
         expect(won_first_point.user_game_score_translation).to eq "15"
        end
      
       it "returns a score of 0 for opponent" do
         expect(won_first_point.opponent_game_score_translation).to eq "0"  
       end
    end

    describe "user wins first two points" do
       let(:current_game) {Game.get(game_data.id)}
       
       before(:each) do
         current_game.user_points = 1
         current_game.opponent_points = 0
         current_game.save
       end
    
      it "returns a score of 30 for user" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "30"
      end
      
      it "returns a score of 0 for opponent" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "0"
      end
    end
  
    describe "user wins first three points" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.user_points = 2
       current_game.save
      end
       
      it "returns a score of 40 for user" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "40"
      end
      
      it "returns a score of 0 for opponent" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "0"
      end
    end
  
    describe "user wins first four points" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.user_points = 3
       current_game.save
      end
      
      it "changes game context to end of game" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.game_context).to eq "end_of_game"
      end
      
      it "increments set score" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_set_score).to eq 5
      end
    end
   #################
    describe "opponent wins first point" do
      let(:current_game) {Game.get(game_data.id)} 
      
      it "returns a score of 0 for user" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.user_game_score_translation).to eq "0"
      end
      
      it "returns a score of 15 for opponent" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.opponent_game_score_translation).to eq "15"
      end
    end

    describe "opponent wins first two points" do
      let(:current_game) {Game.get(game_data.id)}
    
      before(:each) do
       current_game.opponent_points = 1
       current_game.save
      end

      it "returns a score of 0 for user" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.user_game_score_translation).to eq "0"
      end
      
      it "returns a score of 30 for opponent" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.opponent_game_score_translation).to eq "30"
      end
    end

    describe "opponent wins first three points" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.opponent_points = 2
       current_game.save
      end

      it "returns a score of 0 for user" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.user_game_score_translation).to eq "0"
      end
      
      it "returns a score of 40 for user" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.opponent_game_score_translation).to eq "40"
      end
    end

    describe "opponent wins first four points" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.opponent_points = 3
       current_game.save
      end
      
      it "changes game context" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.game_context).to eq "end_of_game"

      end
      
      it "increments set score" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.opponent_set_score).to eq 5
      end
    end
  
    describe "opponents split first two points" do
      let(:current_game) {Game.get(game_data.id)}

      it "returns a user score of 15" do
        current_game, current_question = Game.play(incorrect_answer)
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "15"
      end
      
      it "returns an opponent score of 15" do
        current_game, current_question = Game.play(incorrect_answer)
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "15"
      end
    end
  
    describe "opponents split first four points" do
      let(:current_game) {Game.get(game_data.id)}

      before(:each) do
       current_game.user_points = 2
       current_game.opponent_points = 1
       current_game.save
      end

      it "returns a user score of 30" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.user_game_score_translation).to eq "30"
      end
      
      it "returns an opponent score of 30" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.opponent_game_score_translation).to eq "30"
      end
    end
      
    describe "user wins two of first three points" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.user_points = 1
       current_game.opponent_points = 1
       current_game.save
      end

      it "returns a user score of 30" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "30"
      end 
      
      it "returns an opponent score of 15" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "15"
      end
    end
  
    describe "user has one point, opponent has two" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.user_points = 1
       current_game.opponent_points = 1
       current_game.save
      end

      it "returns a user score of 15" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.user_game_score_translation).to eq "15"
      end
      
      it "returns an opponent score of 30" do
        current_game, current_question = Game.play(incorrect_answer)
        expect(current_game.opponent_game_score_translation).to eq "30"
      end
    end
  
    describe "user has three points, opponent has one" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.user_points = 2
       current_game.opponent_points = 1
       current_game.save
      end

      it "returns a user score of 40" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "40"
      end
      
      it "returns an opponent score of 15" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "15"
      end
      
    end
      
    describe "one point to three" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.opponent_points = 3
       current_game.save
      end

      it "returns a user score of 15" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "15"
      end
      
      it "returns an opponent score of 40" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "40"
      end
      
    end
      
      
    describe "deuce" do
      let(:current_game) {Game.get(game_data.id)}
      
      before(:each) do
       current_game.opponent_points = 4
       current_game.user_points = 4
       current_game.save
      end
      
      describe "user wins next point" do
        it "returns score of user advantage" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.user_game_score_translation).to eq "Ad"
        end
        
        it "returns score of \'-\' for opponent" do
        current_game, current_question = Game.play(correct_answer)
        expect(current_game.opponent_game_score_translation).to eq "-"
        end
      end
          
      describe "opponent wins next point" do
        it "returns score of \'-\' for user" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.user_game_score_translation).to eq "-"
        end

        it "returns score of \'-\' for opponent" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.opponent_game_score_translation).to eq "Ad"
        end
      end
          
      describe "user wins next two points" do
         before(:each) do
           current_game.opponent_points = 4
           current_game.user_points = 5
           current_game.save
          end
        
        it "changes game context" do
          current_game, current_question = Game.play(correct_answer)
          expect(current_game.game_context).to eq "end_of_game"
        end

        it "increments set score" do
          current_game, current_question = Game.play(correct_answer)
          expect(current_game.user_set_score).to eq 5
        end
      end
          
      describe "opponent wins next two points" do
        before(:each) do
         current_game.opponent_points = 5
         current_game.user_points = 4
         current_game.save
        end
        
        
        it "changes game context" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.game_context).to eq "end_of_game"
        end

        it "increments set score" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.opponent_set_score).to eq 5
        end
      end
    end
    describe "user advantage" do
      describe "second deuce" do
        let(:current_game) {Game.get(game_data.id)}
        
        before(:each) do
         current_game.opponent_points = 5
         current_game.user_points = 4
         current_game.save
        end
        
        it "returns a score of deuce for user" do
          current_game, current_question = Game.play(correct_answer)
          expect(current_game.user_game_score_translation).to eq "Deuce"
        end
        
        it "returns a score of deuce for opponent" do
          current_game, current_question = Game.play(correct_answer)
          expect(current_game.opponent_game_score_translation).to eq "Deuce"
        end
      end
    end
  
    
      describe "opponent advantage" do
        describe "second deuce" do
           let(:current_game) {Game.get(game_data.id)}

            before(:each) do
             current_game.opponent_points = 4
             current_game.user_points = 5
             current_game.save
            end

            it "returns a score of deuce for user" do
              current_game, current_question = Game.play(incorrect_answer)
              expect(current_game.user_game_score_translation).to eq "Deuce"
            end

            it "returns a score of deuce for opponent" do
              current_game, current_question = Game.play(incorrect_answer)
              expect(current_game.opponent_game_score_translation).to eq "Deuce"
            end
        end
      end
    end #end game scoring
      
    describe "set scoring" do
      describe "user wins set 6-4" do
        let(:current_game) {Game.get(game_data.id)}
     
         before(:each) do
          current_game.user_points = 3
          current_game.opponent_points = 0
          current_game.user_set_score = 5
          current_game.opponent_set_score = 4
          current_game.save
         end
     
        it "sets game context to end of set" do
          current_game, current_question = Game.play(correct_answer)
          expect(current_game.game_context).to eq "end_of_set"
        end
      end
    
      describe "opponent wins set 6-4" do
        let(:current_game) {Game.get(game_data.id)}
     
       before(:each) do
        current_game.user_points = 0
        current_game.opponent_points = 3
        current_game.user_set_score = 4
        current_game.opponent_set_score = 5
        current_game.save
       end
     
        it "sets game context to end of set" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.game_context).to eq "end_of_set"
        end
      end
      
      describe "user wins set 7-5" do
        let(:current_game) {Game.get(game_data.id)}

        before(:each) do
          current_game.user_points = 3
          current_game.opponent_points = 0
          current_game.user_set_score = 6
          current_game.opponent_set_score = 5
          current_game.save
        end
       
        it "results in user score of 7" do
         current_game, current_question = Game.play(correct_answer)
         expect(current_game.user_set_score).to eq 7
        end

        it "results in an opponent score of 5" do
         current_game, current_question = Game.play(correct_answer)
         expect(current_game.opponent_set_score).to eq 5
        end

        it "sets game context to end of set" do
         current_game, current_question = Game.play(correct_answer)
         expect(current_game.game_context).to eq "end_of_set"
        end
      end
      
      describe "opponent wins set 7-5" do
        let(:current_game) {Game.get(game_data.id)}

        before(:each) do
          current_game.user_points = 0
          current_game.opponent_points = 3
          current_game.user_set_score = 5
          current_game.opponent_set_score = 6
          current_game.save
        end
       
        it "results in user score of 5" do
         current_game, current_question = Game.play(incorrect_answer)
         expect(current_game.user_set_score).to eq 5
        end

        it "results in an opponent score of 7" do
         current_game, current_question = Game.play(incorrect_answer)
         expect(current_game.opponent_set_score).to eq 7
        end

        it "sets game context to end of set" do
         current_game, current_question = Game.play(incorrect_answer)
         expect(current_game.game_context).to eq "end_of_set"
        end
        
      
      end
      
      describe "user goes ahead 6-5" do
         let(:current_game) {Game.get(game_data.id)}

        before(:each) do
          current_game.user_points = 3
          current_game.opponent_points = 0
          current_game.user_set_score = 5
          current_game.opponent_set_score = 5
          current_game.save
        end

        it "results in user score of 6" do
         current_game, current_question = Game.play(correct_answer)
         expect(current_game.user_set_score).to eq 6
        end

        it "results in an opponent score of 5" do
         current_game, current_question = Game.play(correct_answer)
         expect(current_game.opponent_set_score).to eq 5
        end

        it "sets game context to end of set" do
         current_game, current_question = Game.play(correct_answer)
         expect(current_game.game_context).to eq "end_of_game"
        end

      end
      
      describe "opponent goes ahead 6-5" do
         let(:current_game) {Game.get(game_data.id)}

        before(:each) do
          current_game.user_points = 0
          current_game.opponent_points = 3
          current_game.user_set_score = 5
          current_game.opponent_set_score = 5
          current_game.save
        end

        it "results in user score of 6" do
         current_game, current_question = Game.play(incorrect_answer)
         expect(current_game.user_set_score).to eq 5
        end

        it "results in an opponent score of 5" do
         current_game, current_question = Game.play(incorrect_answer)
         expect(current_game.opponent_set_score).to eq 6
        end

        it "sets game context to end of set" do
         current_game, current_question = Game.play(incorrect_answer)
         expect(current_game.game_context).to eq "end_of_game"
        end
      end
      
      describe "enter a tiebreak; score at 6-6" do
        let(:current_game) {Game.get(game_data.id)}

        before(:each) do
          current_game.user_points = 0
          current_game.opponent_points = 3
          current_game.user_set_score = 6
          current_game.opponent_set_score = 5
          current_game.save
        end
        it "should change the game context to tiebreak" do
          current_game, current_question = Game.play(incorrect_answer)
           expect(current_game.tiebreaker).to eq "true"
        end
        
        it "should start with a user tiebreak score of 0" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.user_tiebreak).to eq 0
        end
        
        it "should start with an opponent tiebreak score of 0" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.opponent_tiebreak).to eq 0
        end      
      end
      
      describe "a tiebreaker" do
        let(:current_game) {Game.get(game_data.id)}
        

        before(:each) do
          current_game.user_points = 3
          current_game.opponent_points = 0
          current_game.user_set_score = 5
          current_game.opponent_set_score = 6
          current_game.save
          Game.play(correct_answer)
        end
        
        it "should have a game context of tiebreak" do
          current_game = Game.get(game_data.id)
          expect(current_game.tiebreaker).to eq "true"
        end
        
        it "should increment user tiebreak score for a correct answer" do
          current_game, current_question = Game.play(correct_answer)
          expect(current_game.user_tiebreak).to eq 1
        end
        
        it "should increment opponent tiebreak score for an incorrect answer" do
          current_game, current_question = Game.play(incorrect_answer)
          expect(current_game.opponent_tiebreak).to eq 1
        end
      end
      
       describe "end of tiebreaker" do
        let(:current_game) {Game.get(game_data.id)}

        before(:each) do
          current_game.user_tiebreak = 6
          current_game.opponent_tiebreak = 5
          current_game.user_set_score = 6
          current_game.opponent_set_score = 6
          current_game.tiebreaker = "true"
          current_game.save
        end
          
          describe "one player has 7 or more points in tiebreak" do
            describe "user has seven points" do
              describe "opponent has five points or less" do
                it "changes game context to end of set" do
                  current_game, current_question = Game.play(correct_answer)
                  expect(current_game.game_context).to eq "end_of_set"
                end
                
                it "returns a user_set_score of 7" do
                  current_game, current_question = Game.play(correct_answer)
                  expect(current_game.user_set_score).to eq 7
                end
                
                it "returns an opponent_set_score of 6" do
                  current_game, current_question = Game.play(correct_answer)
                  expect(current_game.opponent_set_score).to eq 6
                end
              end
              
               describe "opponent has six points" do
                before(:each) do
                   current_game.user_tiebreak = 6
                   current_game.opponent_tiebreak = 6
                   current_game.user_set_score = 6
                   current_game.opponent_set_score = 6
                   current_game.tiebreaker = "true"
                   current_game.save
                 end
                   
                   it "game context should be end_of_point" do
                     current_game, current_question = Game.play(correct_answer)
                     expect(current_game.game_context).to eq "end_of_point"
                   end

                   it "returns a user_set_score of 6" do
                     current_game, current_question = Game.play(correct_answer)
                     expect(current_game.user_set_score).to eq 6
                   end

                   it "returns an opponent_set_score of 6" do
                     current_game, current_question = Game.play(correct_answer)
                     expect(current_game.opponent_set_score).to eq 6
                   end
                   
                  it "returns a user_tiebreak of 7" do
                     current_game, current_question = Game.play(correct_answer)
                     expect(current_game.user_tiebreak).to eq 7
                   end

                   it "returns an opponent_tiebreak of 6" do
                     current_game, current_question = Game.play(correct_answer)
                     expect(current_game.opponent_tiebreak).to eq 6
                   end
                   
                 end
                
                
                describe "opponent has seven points" do
                   before(:each) do
                       current_game.user_tiebreak = 6
                       current_game.opponent_tiebreak = 7
                       current_game.user_set_score = 6
                       current_game.opponent_set_score = 6
                       current_game.tiebreaker = "true"
                       current_game.save
                     end
                 it "game context should be end of point" do
                    current_game, current_question = Game.play(correct_answer)
                    expect(current_game.game_context).to eq "end_of_point"
                 end
              
                 it "returns a user_set_score of 6" do
                   current_game, current_question = Game.play(correct_answer)
                   expect(current_game.user_set_score).to eq 6
                 end
                 
                 it "returns an opponent_set_score of 6" do
                   current_game, current_question = Game.play(correct_answer)
                   expect(current_game.opponent_set_score).to eq 6
                 end
                 
                 it "returns a user_tiebreak of 7" do
                    current_game, current_question = Game.play(correct_answer)
                    expect(current_game.user_tiebreak).to eq 7
                 end

                 it "returns an opponent_tiebreak of 7" do
                  current_game, current_question = Game.play(correct_answer)
                  expect(current_game.opponent_tiebreak).to eq 7
                 end
                end
                
                describe "opponent has eight points" do
                  before(:each) do
                    current_game.user_tiebreak = 7
                    current_game.opponent_tiebreak = 7
                    current_game.user_set_score = 6
                    current_game.opponent_set_score = 6
                    current_game.tiebreaker = "true"
                    current_game.save
                  end
                  
                   it "game context should be end of point" do
                      current_game, current_question = Game.play(incorrect_answer)
                      expect(current_game.game_context).to eq "end_of_point"
                   end

                   it "returns a user_set_score of 6" do
                     current_game, current_question = Game.play(incorrect_answer)
                     expect(current_game.user_set_score).to eq 6
                   end

                   it "returns an opponent_set_score of 6" do
                     current_game, current_question = Game.play(incorrect_answer)
                     expect(current_game.opponent_set_score).to eq 6
                   end

                   it "returns a user_tiebreak of 7" do
                      current_game, current_question = Game.play(incorrect_answer)
                      expect(current_game.user_tiebreak).to eq 7
                   end

                   it "returns an opponent_tiebreak of 8" do
                    current_game, current_question = Game.play(incorrect_answer)
                    expect(current_game.opponent_tiebreak).to eq 8
                   end
                end
                
                describe "opponent has nine points" do
                  before(:each) do
                    current_game.user_tiebreak = 7
                    current_game.opponent_tiebreak = 8
                    current_game.user_set_score = 6
                    current_game.opponent_set_score = 6
                    current_game.tiebreaker = "true"
                    current_game.save
                  end
                    it "game context should be end of set" do
                      current_game, current_question = Game.play(incorrect_answer)
                      expect(current_game.game_context).to eq "end_of_set"
                   end

                   it "returns a user_set_score of 6" do
                     current_game, current_question = Game.play(incorrect_answer)
                     expect(current_game.user_set_score).to eq 6
                   end

                   it "returns an opponent_set_score of 7" do
                     current_game, current_question = Game.play(incorrect_answer)
                     expect(current_game.opponent_set_score).to eq 7
                   end

                   it "returns a user_tiebreak of 7" do
                      current_game, current_question = Game.play(incorrect_answer)
                      expect(current_game.user_tiebreak).to eq 7
                   end

                   it "returns an opponent_tiebreak of 9" do
                    current_game, current_question = Game.play(incorrect_answer)
                    expect(current_game.opponent_tiebreak).to eq 9
                   end
                end
              end
            end
        end
    end
  end #end scoring
end

