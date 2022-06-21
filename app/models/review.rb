class Review < ApplicationRecord
  belongs_to :apartment

  validates :content, presence: true
end
