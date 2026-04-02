class Article < ApplicationRecord
  include Visible
  belongs_to :category
  belongs_to :user
  has_many :comments
  validates :title, presence: true
end
