class Chat
  messages: {}

  addMessage: (msg) ->
    # Do nothing when @messages already has message, as the message is already shown
    unless @messages[msg.id]
      @messages[msg.id] = msg
      @showMessage(msg)

  handleSocketResponse: (msg) ->
    @addMessage(msg)
    console.log "Triggered"

  showMessage: (message) ->
    template = $('#message_template').html();
    Mustache.parse(template);
    rendered = Mustache.render(template, {message: message});
    $('#messages').prepend(rendered)

  showMessages: (messages) ->
    @showMessage(message) for message in JSON.parse(messages)

@chat = new Chat