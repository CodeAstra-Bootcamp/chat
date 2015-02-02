class MessagesController < ApplicationController
  PER_PAGE = 10

  def index
    if request.xhr?
      @messages = Message.limit(PER_PAGE).order('id DESC')
      if params[:threshold]
        @messages = @messages.where('id < ?', params[:threshold])
      end
      @messages = @messages.collect(&:for_pubnub)
      @last_message = @messages.last
      @messages = @messages.to_json
      @end_reached = @last_message.nil? || (@last_message[:id] == Message.first.id)
    else
      @new_message = Message.new
    end
  end

  def create
    @message = current_user.messages.new(message_params)
    @save_success = @message.save
  end

  private

    def message_params
      params.require(:message).permit(:nick, :note)
    end
end
