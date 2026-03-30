class Article < ApplicationRecord
  include Visible
  belongs_to :category
  has_many :comments
  validates :title, presence: true
end
