class Article < ApplicationRecord
  include Visible
  has_many :comments
  validates :title, presence: true
end
