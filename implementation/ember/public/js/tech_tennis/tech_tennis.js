// whatever setup config to point to templates, models, etc.

window.TechTennis = Ember.Application.create();

TechTennis.Router.map(function() {
	this.resource('greeting', {path: "/"});
	this.resource('gamespace');
	this.resource('correct_response');
	this.resource('incorrect_response');
	this.resource('endgame');
	this.resource('endset');
});

TechTennis.ApplicationRoute = Ember.Route.extend({
	setupController: function() {
		this.controllerFor('game').set('model', TechTennis.Game.find());
	}
});



TechTennis.GamespaceRoute = Ember.Route.extend({
	model: function() {
		return TechTennis.Game.find();
	}	// 
		// 
		// events: {
		// 	processQuestion: function(answer) {
		// 		
		// 	},
		// 	
		// 	// processScore: function() {
		// 	// 
		// 	// 	}
		// }
	
});

TechTennis.GreetingRoute = Ember.Route.extend({
 	model: function(params) {
		return TechTennis.Greeting.find();
	},
	
	events: {
		startGame: function() {
			
			this.transitionTo('gamespace');
		}
	}
});

TechTennis.EndgameRoute = Ember.Route.extend({
  model: function() {
		return TechTennis.Game.find();
	}
  
});

TechTennis.EndsetRoute = Ember.Route.extend({
  model: function() {
		return TechTennis.Game.find();
	}
  
});





//Views

TechTennis.GreeterView = Ember.View.extend({
  	click: function(evt) {
	    this.get('controller').send('startGame');
	  }
});

TechTennis.AnswerAView = Ember.View.extend({
  	click: function(evt) {
		var user_answer = $('#answer_a').text();
	    this.get('controller').send('processQuestion', user_answer);
	 	this.get('controller').send('processScore', user_answer);
	  }
});



TechTennis.AnswerBView = Ember.View.extend({
  
    click: function(evt) {
		var user_answer = $('#answer_b').text();
	    this.get('controller').send('processQuestion', user_answer);
	 	this.get('controller').send('processScore', user_answer);
	  }

});

TechTennis.AnswerCView = Ember.View.extend({
  	click: function(evt) {
		var user_answer = $('#answer_c').text();
	    this.get('controller').send('processQuestion', user_answer);
	  }
});

TechTennis.AnswerDView = Ember.View.extend({
  	click: function(evt) {
		var user_answer = $('#answer_d').text();
	    this.get('controller').send('processQuestion', user_answer);
	 	this.get('controller').send('processScore', user_answer);
	  }
});


//Controllers
TechTennis.QuestionController = Ember.ArrayController.extend();
TechTennis.GameController = Ember.ArrayController.extend();
TechTennis.GreetingController = Ember.ArrayController.extend();

// TechTennis.EndgameController = Ember.ArrayController.extend({
// 	needs: 'scoreboard'
// });



//Models

DS.RESTAdapter.map('TechTennis.Game',{
    questions:{
        embedded:'always'
    }
})
TechTennis.Store = DS.Store.extend({
	revision: 11,
	adapter: 'DS.RESTAdapter'
});

DS.RESTAdapter.map('TechTennis.Question', {
  id: { key: 'question_id' }
});



DS.RESTAdapter.reopen({
  namespace: 'api/v1'
});


// TechTennis.Question = DS.Model.extend({
// 	question_id: DS.attr('string'),
// 	question_text: DS.attr('string'),
// 	answer_option_a: DS.attr('string'),
// 	answer_option_b: DS.attr('string'),
// 	answer_option_c: DS.attr('string'),
// 	answer_option_d: DS.attr('string'),
// 	times_asked: DS.attr('string'),
// 	game_id: DS.attr('string')
// 	});

TechTennis.Game = DS.Model.extend({
	current_role: DS.attr('string'),
	current_quiz_type: DS.attr('string'),
	user_points: DS.attr('string'),
	user_game_score_translation: DS.attr('string'),
	user_set_score: DS.attr('string'),
	opponent_points: DS.attr('string'),
	opponent_game_score_translation: DS.attr('string'),
	opponent_set_score: DS.attr('string'),
	completed_in: DS.attr('string'),
	leftover_time: DS.attr('string'),
	last_result: DS.attr('string'),
	game_context: DS.attr('string'),
	questions: DS.hasMany('TechTennis.Question', {embedded:'always'})
	});

TechTennis.Question = DS.Model.extend({
	question_id: DS.attr('string'),
	question_text: DS.attr('string'),
	answer_option_a: DS.attr('string'),
	answer_option_b: DS.attr('string'),
	answer_option_c: DS.attr('string'),
	answer_option_d: DS.attr('string'),
	times_asked: DS.attr('string'),
	game_id: DS.attr('string')
});

TechTennis.Greeting = DS.Model.extend({
	greeting_text: DS.attr('string')
	});

//Fixtures

// TechTennis.Question.FIXTURES = [{
// 	id: "1",
// 	question_id: "12",
// 	question_text: "What is the meaning of the universe?",
// 	answer_option_a: "42",
// 	answer_option_b: "The way",
// 	answer_option_c: "Look behind you",
// 	answer_option_d: "Hmm...",
// 	times_asked: "3",
// 	game_id: "42"
// }];




