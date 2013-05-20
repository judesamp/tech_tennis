Ext.define('TechTennisApp.view.Question', {
  extend: 'Ext.Container',
  requires: ['Ext.Button'],
  alias: 'widget.questionview',
  config: {
    layout: {
      type: 'vbox'
    },
    items: 
        [   {
            html: "<div id = 'greeting'>We're not quite ready for business. Click to return to the home page.</div>",
            cls: "greeting", 
            flex: 1,
      
                 
            },
            {
            cls: "bottom_gray", 
            flex: 1,
            layout: {
                    pack: 'center',
                    type: 'hbox'
                    },
                items: 
                    [   {
                        xtype: 'button',
                        text: 'Click to Return',
                        cls: 'home_button',
                        ui: 'action round',
                        itemId: 'homeButton'  
                        }
                    ]
            }
        ]
      },
      
      listeners: [{
        delegate: '#homeButton',
        event: 'tap',
        fn: 'onHomeButtonTap'
      }],
    onHomeButtonTap: function () {
      console.log('homeCommand');
      this.fireEvent('homeCommand', this);
    }
});