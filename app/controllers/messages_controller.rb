class MessagesController < ApplicationController
  def index
    @messages = Message.reverse_chron
    @new_message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @save_success = @message.save
  end

  def refresh
    @messages = Message.where('id > ?', params[:latest_id]).reverse_chron
  end

  private

    def message_params
      params.require(:message).permit(:nick, :note)
    end
end
