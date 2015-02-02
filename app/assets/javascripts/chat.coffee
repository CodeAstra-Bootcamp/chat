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

  showMessage: (message, prepend = true) ->
    template = $('#message_template').html();
    Mustache.parse(template);
    rendered = Mustache.render(template, {message: message});
    if prepend
      $('#messages').prepend(rendered)
    else
      $('#messages').append(rendered)

  showMessages: (messages) ->
    @showMessage(message, false) for message in JSON.parse(messages)

@chat = new Chat

$ ->
  if $('#get_messages_link').length
    $(window).scroll ->
      if $('#get_messages_link').length
        if $(window).scrollTop() > $(document).height() - $(window).height() - 50
          $('#get_messages_link').click().replaceWith('<div id="get_messages_link">Loading Messages</div>')

    $(window).scroll()