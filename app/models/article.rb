class Article < ApplicationRecord
  include Visible
  has_many :comments
  validates :title, presence: true
  before_validation :set_default_title
  after_create -> { Rails.logger.info("New article created successfully!") }
  private
  def set_default_title
    self.title = "Untitled Article"
  end
end
