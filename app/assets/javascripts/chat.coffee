class Chat
  messages: {}

  addMessage: (msg) ->
    if @messages[msg.id]
      console.log "#{msg.note} is already there"
    else
      @messages[msg.id] = msg
      @showMessage(msg)
      console.log "#{msg.note} has been added"

  handleSocketResponse: (msg) ->
    @addMessage(msg)

  showMessage: (message) ->
    $('#messages').prepend(@messageForDisplay(message))

  messageForDisplay: (message) ->
    "<div class='message row'><div class='col-xs-2 nick'>#{message.nick}:</div><div class='col-xs-10 note'>#{message.note}<div class='time pull-right'>#{message.time}</div></div></div>"

  showMessages: ->
    @showMessage(message) for message_id, message of @messages      

@chat = new Chat

$ ->
  chat.showMessages()