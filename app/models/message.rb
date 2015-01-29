class Message < ActiveRecord::Base
  scope :reverse_chron, -> {order('created_at DESC')}

  validates :nick, presence: true
  validates :note, presence: true

  after_create :publish_to_pubnub

  def for_pubnub
    {
      id: id,
      nick: nick,
      note: note,
      time: created_at.strftime("at %l:%M  %P on %b %e")
    }
  end

  private

    def publish_to_pubnub
      pubnub_channel.publish(
       channel: "codeastra-chat",
       message: for_pubnub,
       callback: pubnub_callback
      )
    end

    def pubnub_channel
      return @pubnub if @pubnub

      @pubnub = Pubnub.new(
       :publish_key   => PUBNUB_PUBLISH_KEY,
       :subscribe_key => PUBNUB_SUBSCRIBE_KEY,
       :uuid => 'codeastra-chat-server'
       )
    end

    def pubnub_callback
      lambda {}
    end
end
