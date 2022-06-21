class Apartment < ApplicationRecord
  has_many :reviews, dependent: :destroy
end
