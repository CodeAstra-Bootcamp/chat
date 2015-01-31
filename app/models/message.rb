class Message < ActiveRecord::Base
  validates :note, presence: true
  validates :user, presence: true

  belongs_to :user

  after_create :publish_to_pubnub

  def for_pubnub
    {
      id: id,
      name: user.name,
      image: user.image,
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
