Tech Tennis API

Below are the available API endpoints for playing the Tech Tennis game.

Game
----------

Start Game - api/v1/game	GET
	This starts the game
	
Submit Answer - api/vi/game POST
	Submit an answer given a question from the previous response
	
	Inputs
	
		{"answer" : ["<answer 1>, <answer 2>"] }
	
	Outputs
	
		{ "question_data" : 
		
			{"last_answer_response" : "wrong", 
			 "question" : "What is the airspeed velocity of a swallow?",
			 "answer_options" : ["32mph","5mph","2mph","20mph"], 
			 "answer_format" : "radial | checkbox | field"},
			
			"game_data" :
			{"game_id" : "2326", "score" : "2", "staus" : "in progress | complete",
				"wrong_answers" : [
					{"question" : "What does a full title tag look like", 
					 "gamer_answer" : "<title_tag></title_tag>",
					 "correct_answer" : "<title></title>"},
					{"question" : "What does a primary heading tag look like", 
					 "gamer_answer" : "<heading_tag></heading_tag>",
					 "correct_answer" : "<h1></h1>"}
				]
			}
		
		}