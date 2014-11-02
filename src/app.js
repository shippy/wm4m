/**
 * Welcome to Pebble.js!
 *
 * This is where you write your app.
 */

var UI = require('ui');
var Vector2 = require('vector2');
var Vibe = require('ui/vibe');
var Settings = require('settings');

// For demonstration purposes, to reset registration
// localStorage['confirmed'] = 0;

// TODO: Fetch from settings
var user_id = 1;

// Questions
var t_stress_q = new UI.Text({
    position: new Vector2(0, 30),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'What is your \nstress level?',
    textAlign: 'left'
  });

var t_happiness_q = new UI.Text({
    position: new Vector2(0, 30),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'What is your \nhappiness?',
    textAlign: 'left'
  });

// Answers
// var main = new UI.Window();
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

// Display function
function displayQ(question, question_id, top_choice, mid_choice, low_choice, next_q) {
  var i = question_id;
  
  // Set up window
  var main = new UI.Window();
  main.add(question);
  main.add(top_choice);
  main.add(mid_choice);
  main.add(low_choice);
  main.show();
  
  // Set up event responses
  main.on('click', 'up', function(e) {
    r = {'kind': i, 'level': 3, 'user_id': user_id, 'pebble_token': (Pebble.getAccountToken() + "_" + Pebble.getWatchToken())};
    saveLastAnswer();
    main.hide();
    next_q();
  });

  main.on('click', 'select', function(e) {
    r = {'kind': i, 'level': 2, 'user_id': user_id, 'pebble_token': (Pebble.getAccountToken() + "_" + Pebble.getWatchToken())};
    saveLastAnswer();
    main.hide();
    next_q();
  });

  main.on('click', 'down', function(e) {
    r = {'kind': i, 'level': 1, 'user_id': user_id, 'pebble_token': (Pebble.getAccountToken() + "_" + Pebble.getWatchToken())};
    saveLastAnswer();
    main.hide();
    next_q();
  });
}

// Display confirmation function
function gotIt() {
  var wind = new UI.Window();
  var textfield = new UI.Text({
    position: new Vector2(0, 50),
    size: new Vector2(144, 30),
    font: 'gothic-24-bold',
    text: 'Got it!',
    textAlign: 'center'
  });
  
  // Display the text
  wind.add(textfield);
  wind.show();
  
  // Hide it after two seconds, taking the user to menu
  setTimeout(function() { wind.hide() }, 2000)
}

// Display suggestion to register
function goRegister() {
  var wind = new UI.Window();
  var textfield = new UI.Text({
    position: new Vector2(0, 30),
    size: new Vector2(144, 130),
    font: 'gothic-24-bold',
    text: 'You are not signed\nin. On your phone,\n go to Pebble >\nWM4M > Settings.',
    textAlign: 'center'
  });
  
  // Display the text
  wind.add(textfield);
  wind.show();
}

// Submit last question
function saveLastAnswer() {
  var ajax = require('ajax');
  ajax(
    {
      url: 'https://watchme4me.herokuapp.com/responses/add',
      type: 'json',
      data: {response: r},
      method: 'post'
    },
    
    function(error) {
      console.log('The AJAX request failed: ' + error);
    },
    
    function(error) {
      console.log('The AJAX request succeeded: ' + error);
    }
  );
}

// Calls
if (localStorage['confirmed'] == 1) {
  Vibe.vibrate('double');
  displayQ(t_stress_q, 1, t_high, t_med, t_low, function() { 
    displayQ(t_happiness_q, 2, t_high, t_med, t_low, function() { gotIt(); })
  });
} else {
  goRegister();
}

Pebble.addEventListener("showConfiguration", function (e) { 
  console.log("configuration opened");
  Pebble.openURL("http://watchme4me.herokuapp.com/pebble_settings/" + Pebble.getAccountToken() + "_" + Pebble.getWatchToken());
});

Pebble.addEventListener("webviewclosed", function (e) {
  console.log("configuration closed")
  if (e.response != "CANCELLED" || e.response != "") {
    localStorage['confirmed'] = 1;
  }
});