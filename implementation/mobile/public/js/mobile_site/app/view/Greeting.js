Ext.define('TechTennisApp.view.Greeting', {
  extend: 'Ext.Container',
  requires: ['Ext.Button'],
  alias: 'widget.greetingview',
  config: {
    layout: {
      type: 'vbox'
    },
    items: [
    {
      style: "text-align:center; color: white;",
      docked: "top",
      html: "TechTennis",
      cls: "my_titlebar"            
    },
    
    {
      cls: "header_img",
      flex: 1           
    },
    
    {
      html: "<div id = 'greeting'>Welcome to TechTennis, an HTML quiz game based on the sport of kings. The score will start at 4-4 in the final set.</div>",
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
      [{
      xtype: 'button',
      text: 'Click to Play',
      cls: 'play_button',
      ui: 'action round',
      itemId: 'playButton'
      }]           
    }]
  },
  
  listeners: [{
    delegate: '#playButton',
    event: 'tap',
    fn: 'onPlayButtonTap'
  }],
onPlayButtonTap: function () {
  console.log('playCommand');
  this.fireEvent('playCommand', this);
}
});