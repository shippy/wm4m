/**
 * Welcome to Pebble.js!
 *
 * This is where you write your app.
 */

var UI = require('ui');
var Vector2 = require('vector2');

var main = new UI.Window();
var t_high = new UI.Text({
    position: new Vector2(0,0),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'High',
    textAlign: 'right'
  });
var t_med = new UI.Text({
    position: new Vector2(0, 56),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'Med',
    textAlign: 'right'
  });
var t_low = new UI.Text({
    position: new Vector2(0, 112),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'Low',
    textAlign: 'right'
  });

var t_how_are_you = new UI.Text({
    position: new Vector2(0, 30),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'What is your \nstress level?',
    textAlign: 'left'
  });

main.add(t_how_are_you);
main.add(t_high);
main.add(t_med);
main.add(t_low);

main.show();

function gotIt () {
  var wind = new UI.Window();
  var textfield = new UI.Text({
    position: new Vector2(0, 50),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'Got it!',
    textAlign: 'center'
  });
  
  wind.add(textfield);
  wind.show();
  
  var ajax = require('ajax');
  ajax(
    {
      url: 'https://watchme4me.herokuapp.com/responses/add',
      type: 'json',
      data: {response: r},
      method: 'post'
    },
    
    function(data) {
      console.log('Quote of the day is: ' + data.contents.quote);
    },
    
    function(error) {
      console.log('The ajax request failed: ' + error);
    }
  );
  
  wind.psleep(5000);
  wind.hide();
}

main.on('click', 'up', function(e) {
  r = {'kind': 1, 'level': 3, 'user_id': 1, 'pebble_token': (Pebble.getAccountToken() + "_" + Pebble.getWatchToken())};
  gotIt();
});

main.on('click', 'select', function(e) {
  r = {'kind': 1, 'level': 2, 'user_id': 1, 'pebble_token': (Pebble.getAccountToken() + "_" + Pebble.getWatchToken())};
  gotIt();
});

main.on('click', 'down', function(e) {
  r = {'kind': 1, 'level': 1, 'user_id': 1, 'pebble_token': (Pebble.getAccountToken() + "_" + Pebble.getWatchToken())};
  gotIt();
});