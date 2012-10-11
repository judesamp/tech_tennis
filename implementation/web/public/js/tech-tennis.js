var myApp = (function() { 

var dataHolder = function(newData) {
	this.incoming_data = newData;
};

var dataDealer = { 

	

	processNewQuestion: function (game_data) {
				dataDealer.dataHolder(game_data);
			
				$('#question').html(dataDealer.incoming_data.question);
				$('#answer_a').html(dataDealer.incoming_data.answer_options[0]);
				$('#answer_b').html(dataDealer.incoming_data.answer_options[1]);
				$('#answer_c').html(dataDealer.incoming_data.answer_options[2]);
				$('#answer_d').html(dataDealer.incoming_data.answer_options[3]);
				$('#clock').load('/clock');
		},

			processAnswer: function() {
				$('#multiplechoice').fadeOut().delay(500).hide();
				
				$.getJSON('api/v1/question', dataDealer.processNewQuestion);
				
			
	//$('#clock').animate({backgroundColor: 'rgb(0,255,0)'});
	//$('#scoreboard').animate({backgroundColor: '#00FF00'});
			
		//		$('#correct').fadeIn(900).delay(1200).fadeOut(function() {
					

			//		$('#questionbox').fadeIn(1200);
				//	$('#clock').animate({backgroundColor: '#FFF'});
					//$('#scoreboard').animate({backgroundColor: '#FFF'});
						//$("#multiplechoice").fadeIn(1200);
						
						
				
				//incorrect
				$('#clock').animate({backgroundColor: '#F00000")'});
				$('#scoreboard').animate({backgroundColor: '"#F00000")'});
			
				
				$('#incorrect').fadeIn(1200).delay(1200).fadeOut(function() {
					$('#clock').animate({backgroundColor: '#FFF'});
					$('#scoreboard').animate({backgroundColor: '#FFF'});
							$("#multiplechoice").fadeIn(1200);

						//end fade in multiple choice/create clock
					});

			}
			
	};
	
		dataDealer.dataHolder = dataHolder; 
	
$(document).ready(function() {
	$('#ready').hide();
	$('#correct').hide();
	$('#incorrect').hide();
	$('#multiplechoice').hide();
	
		$('#playasguestbutton').click(function(){
			$('#greeter').hide();
			$.getJSON('api/v1/question', dataDealer.processNewQuestion);
			$('#ready').fadeIn().delay(1200).fadeOut(function() {
				$("#multiplechoice").fadeIn();
			
			//end fade in multiple choice/create clock
		}); //end for prepare-to-play page
		}); //end of "play as guest" sequence
		

			
			
					$('#a').click(function() {
						dataDealer.incoming_data.user_answer = $('#answer_a').text();
						$.getJSON('api/v1/answer', dataDealer.incoming_data);	
						$.getJSON('api/v1/question', dataDealer.processNewQuestion);
						}); //end "a" click

						$('#b').click(function() {
							dataDealer.incoming_data.user_answer = $('#answer_b').text();
							$.getJSON('api/v1/answer', dataDealer.incoming_data);	
							$.getJSON('api/v1/question', dataDealer.processNewQuestion);	
							}); //end "b" click

							$('#c').click(function() {
								dataDealer.incoming_data.user_answer = $('#answer_c').text();
								$.getJSON('api/v1/answer', dataDealer.incoming_data);
								dataDealer.processAnswer();	
								
			
								
								}); //end "c" click

								$('#d').click(function() {
									dataDealer.incoming_data.user_answer = $('#answer_d').text();
									$.getJSON('api/v1/answer', dataDealer.incoming_data);	
									$.getJSON('api/v1/question', dataDealer.processNewQuestion);
									}); //end "d" click

										

			
		

}); //end ready
	}) (myApp); //end javascript