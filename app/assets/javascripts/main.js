$(function() {
  // Here we instantiate a new WebSocketRails instance
  // var dispatcher = new WebSocketRails('localhost:3000/websocket');
  // // var dispatcher2 = new WebSocketRails($('#echo').data('uri'), true);
  // // We send the message when we push the 'send button'
  // document.querySelector('button#fire').onclick = function() {
  //   send({message: document.querySelector('#send').value, user_id: App.globals.current_user.id});
  //   document.querySelector('#send').value = '';
  // };

  // // We bind the incoming message event
  // dispatcher.bind('new_message',
  //   function(data) {
  //     alert(data);
  //     document.querySelector('#messages').innerHTML += '<li>' + data.message + '</li>'
  //   });

  // dispatcher.on_open = function() {
  //   var tweet_channel = dispatcher.subscribe('tweets');
  //   console.log(tweet_channel);
  //   tweet_channel.bind('deliver', function(tweet){
  //     console.log('yes!');
  //     $('#twe_status').html('fre' + tweet.text);
  //   });
  // }
  // document.querySelector("#sir").onclick = function(e) {
  //   e.preventDefault();
  //   alert('LOp');
  //   tweet_channel.trigger('deliver', {
  //     text: 'All cool'
  //   });
  // }

});

// Here we send the message in the websocket
// function send(data) {
//   dispatcher.trigger('new_message', data);
// }