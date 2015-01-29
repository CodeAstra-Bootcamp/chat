class MessagesController < ApplicationController
  def index
    if request.xhr?
      @messages = Message.all.collect(&:for_pubnub).to_json
    else
      @new_message = Message.new
    end
  end

  def create
    @message = Message.new(message_params)
    @save_success = @message.save
  end

  private

    def message_params
      params.require(:message).permit(:nick, :note)
    end
end
