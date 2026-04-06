class User < ApplicationRecord
  has_many :articles

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :notify_new_user   # ✅ ADD THIS

  private

  def notify_new_user
    ActionCable.server.broadcast("notifications_channel", {
      message: "New user registered: #{email}"
    })
  end
end
