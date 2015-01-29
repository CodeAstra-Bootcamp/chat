class Message < ActiveRecord::Base
  scope :reverse_chron, -> {order('created_at DESC')}

  validates :nick, presence: true
  validates :note, presence: true
end
