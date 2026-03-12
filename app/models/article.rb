class Article < ApplicationRecord
  include Visible
  has_many :comments
  validates :title, presence: true
  after_create :send_notification

  private
  def send_notification
    puts "article is created"
  end
end
