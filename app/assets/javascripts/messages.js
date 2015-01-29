$( document ).ready(function() {
  var CHAT_PUBNUB = PUBNUB.init({
    publish_key: 'pub-c-f3905f29-1de9-4734-97fa-7c35eebb2aea',
    subscribe_key: 'sub-c-d20157de-a7a9-11e4-aa71-02ee2ddab7fe'
  });

  CHAT_PUBNUB.unsubscribe({
    channel: 'codeastra-chat'
  });

  CHAT_PUBNUB.subscribe({
    channel: 'codeastra-chat',
    message: function(m){chat.handleSocketResponse(m)}
  });
});