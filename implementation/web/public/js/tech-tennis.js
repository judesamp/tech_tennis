var myApp = (function() { 

var dataHolder = function(newData) {
	this.incoming_data = newData;
};

var dataDealer = { 

	

	processNewQuestion: function(game_data) {
				dataDealer.dataHolder(game_data);
				if (dataDealer.incoming_data.last_result != "none") {
				dataDealer.processAnswer(dataDealer.incoming_data.last_result, dataDealer.incoming_data.game_context);
			};
			$('#player_set_score').html(dataDealer.incoming_data.user_set_score).fadeIn();
			$('#opponent_set_score').html(dataDealer.incoming_data.opponent_set_score).fadeIn();
			$('#player_game_score').html(dataDealer.incoming_data.user_game_score_translation).fadeIn();
			$('#opponent_game_score').html(dataDealer.incoming_data.opponent_game_score_translation).fadeIn();
			$('#current_quiz_type').html(dataDealer.incoming_data.current_quiz_type).fadeIn();
			
			
			
				$('#question').html(dataDealer.incoming_data.question.question_text);
					$('#answer_a').html(dataDealer.incoming_data.question.answer_option_a);
					$('#answer_b').html(dataDealer.incoming_data.question.answer_option_b);
					$('#answer_c').html(dataDealer.incoming_data.question.answer_option_c);
					$('#answer_d').html(dataDealer.incoming_data.question.answer_option_d);			
		},
		
		animateNewQuestion: function() {
			$('#questionaire').fadeIn(1200);
			$('#answers').fadeIn(1200);
			$('#scoreboard').animate({backgroundColor: '#FFF'});
		},
		
		
		playAgain: function() {
			$('#playagainbutton').on("click", function(){
				$.getJSON('api/v1/start', dataDealer.processNewQuestion);
				$('#end_of_set').hide();
				$('#ready').fadeIn().delay(1200).fadeOut(function() {
					$("#questionaire").fadeIn();
					$('#answers').fadeIn();
		});});
		},

			processAnswer: function(result, game_context) {
			
				
				$('#questionaire').fadeOut().delay(300).hide();
				if (result == "correct") {		
					//$('.white_stripe').animate({backgroundColor: 'rgb(0,255,0)'});
					
						
						if (game_context == "end_of_point") {
							$('#correct').fadeIn(900).delay(1200).fadeOut(dataDealer.animateNewQuestion);} 
						else if (game_context == "end_of_game") {
			
							$('.player_set_score').html(dataDealer.incoming_data.user_set_score).fadeIn();
							$('.opponent_set_score').html(dataDealer.incoming_data.opponent_set_score).fadeIn();
							$('#end_of_game').fadeIn(900).delay(1200).fadeOut(dataDealer.animateNewQuestion);}
						else if (game_context == "end_of_set"){
							$('.player_set_score').html(dataDealer.incoming_data.user_set_score).fadeIn();
							$('.opponent_set_score').html(dataDealer.incoming_data.opponent_set_score).fadeIn();
							$('#answers').hide();
							$('#end_of_set').fadeIn(dataDealer.playAgain);}
						
						
						
							
							
			}	 else {
				
				//incorrect
				//$('.white_stripe').animate({backgroundColor: '"#F00000'});
						if (game_context == "end_of_point") {
							$('#incorrect').fadeIn(900).delay(1200).fadeOut(dataDealer.animateNewQuestion);} 
						else if (game_context == "end_of_game") {
							$('.player_set_score').html(dataDealer.incoming_data.user_set_score).fadeIn();
							$('.opponent_set_score').html(dataDealer.incoming_data.opponent_set_score).fadeIn();
							$('#end_of_game').fadeIn(900).delay(1200).fadeOut(dataDealer.animateNewQuestion);}
						else 	{
							$('.player_set_score').html(dataDealer.incoming_data.user_set_score).fadeIn();
							$('.opponent_set_score').html(dataDealer.incoming_data.opponent_set_score).fadeIn();
							$('#end_of_set').fadeIn(900, dataDealer.playAgain);}}

						//end fade in multiple choice/create clock
				
				}}

		dataDealer.dataHolder = dataHolder; 
	
$(document).ready(function() {	
		$('#playasguestbutton').on("click", function(){
			$('.greeter').hide();
			$.getJSON('api/v1/start', dataDealer.processNewQuestion);
			$('#ready').fadeIn().delay(1200).fadeOut(function() {
				$('#answers').fadeIn();
				$("#questionaire").fadeIn();
				
			
			//end fade in multiple choice/create clock
		}); //end for prepare-to-play page
		}); //end of "play as guest" sequence
		

			
			
					$('#a').click(function() {
						dataDealer.incoming_data.user_answer = $('#answer_a').text();
						$.getJSON('api/v1/play', dataDealer.incoming_data, dataDealer.processNewQuestion);	
						}); //end "a" click

						$('#b').click(function() {
							dataDealer.incoming_data.user_answer = $('#answer_b').text();
							$.getJSON('api/v1/play', dataDealer.incoming_data, dataDealer.processNewQuestion);
							}); //end "b" click

							$('#c').click(function() {
								dataDealer.incoming_data.user_answer = $('#answer_c').text();
								$.getJSON('api/v1/play', dataDealer.incoming_data, dataDealer.processNewQuestion);
								}); //end "c" click

								$('#d').click(function() {
									dataDealer.incoming_data.user_answer = $('#answer_d').text();
									$.getJSON('api/v1/play', dataDealer.incoming_data, dataDealer.processNewQuestion);	
									}); //end "d" click

										

			
		

}); //end ready
	}) (myApp); //end javascript