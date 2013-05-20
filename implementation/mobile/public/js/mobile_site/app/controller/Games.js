Ext.define('TechTennisApp.controller.Games', {
  extend: 'Ext.app.Controller',
  
  config: {
    refs: {
      greetingView: 'greetingview',
      questionView: 'questionview'
    },
    control: {
      greetingView: {
        playCommand: 'onPlayCommand',
      },
      questionView: {
        homeCommand: 'onHomeCommand',
      }
    }
  },
  
  slideLeftTransition: { type: 'slide', direction: 'left' },
  slideRightTransition: { type: 'slide', direction: 'right' },
  
  onPlayCommand: function () {
    console.log('onPlayCommand');
    var questionView = this.getQuestionView();
    Ext.Viewport.animateActiveItem(questionView, this.slideLeftTransition);
  },
  
  onHomeCommand: function () {
    console.log('onHomeCommand');
    var greetingView = this.getGreetingView();
    Ext.Viewport.animateActiveItem(greetingView, this.slideRightTransition);
  },
  

});