Ext.application({
    name: 'TechTennisApp',

    // models: [ 'Note' ],
    controllers: ['Games'],
//     stores: [ 'Notes' ],
    views: [ 'Greeting', 'Question'],
    
    launch: function () {
      
      var greetingView = {
        xtype: 'greetingview'
      };
      
      var questionView = {
          xtype: 'questionview'
      };
      
      
      Ext.Viewport.add([greetingView, questionView]);
    }
    
});
