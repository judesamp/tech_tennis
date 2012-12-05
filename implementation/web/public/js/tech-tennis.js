var myApp = (function() { 

var dataHolder = function(newData) {
	this.incoming_data = newData;
};

var dataDealer = { 

	

	processNewQuestion: function(game_data) {
				dataDealer.dataHolder(game_data);
				if (dataDealer.incoming_data.last_result) {
				dataDealer.processAnswer(dataDealer.incoming_data.last_result);
			};
			$('#player_game_score').html(dataDealer.incoming_data.user_set).fadeIn();
			$('#opponent_game_score').html(dataDealer.incoming_data.opponent_set).fadeIn();
			$('#player_score').html(dataDealer.incoming_data.user_game).fadeIn();
			$('#opponent_score').html(dataDealer.incoming_data.opponent_game).fadeIn();
			
			
			
				$('#question').html(dataDealer.incoming_data.question);
					$('#answer_a').html(dataDealer.incoming_data.answer_option_a);
					$('#answer_b').html(dataDealer.incoming_data.answer_option_b);
					$('#answer_c').html(dataDealer.incoming_data.answer_option_c);
					$('#answer_d').html(dataDealer.incoming_data.answer_option_d);
					$('#clock').load('/clock');		
					
				
		
		},

			processAnswer: function(result) {
				
				$('#multiplechoice').fadeOut().delay(300).hide();
				if (result == 2) {		
					$('#clock').animate({backgroundColor: 'rgb(0,255,0)'});
					$('#scoreboard').animate({backgroundColor: '#00FF00'});
					$('#correct').fadeIn(900).delay(1200).fadeOut(function() {
					$('#questionbox').fadeIn(1200);
					$('#clock').animate({backgroundColor: '#FFF'});
					$('#scoreboard').animate({backgroundColor: '#FFF'});
					$("#multiplechoice").fadeIn(1200);
					});} else {
				
				//incorrect
				$('#clock').animate({backgroundColor: '#F00000'});
				$('#scoreboard').animate({backgroundColor: '"#F00000'});
				$('#incorrect').fadeIn(900).delay(1000).fadeOut(function() {
					$('#clock').animate({backgroundColor: '#FFF'});
					$('#scoreboard').animate({backgroundColor: '#FFF'});
						$("#multiplechoice").fadeIn(1200);

						//end fade in multiple choice/create clock
					});
				}
}
}
		dataDealer.dataHolder = dataHolder; 
	
$(document).ready(function() {	
		$('#playasguestbutton').click(function(){
			$('#greeter').hide();
			$.getJSON('api/v1/start', dataDealer.processNewQuestion);
			$('#ready').fadeIn().delay(1200).fadeOut(function() {
				$("#multiplechoice").fadeIn();
			
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