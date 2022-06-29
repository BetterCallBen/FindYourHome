class Apartment < ApplicationRecord
  belongs_to :city

  validates :name, presence: true
  validates :address, presence: true
  validates :surface, presence: true
  validates :rooms, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
end
