class Apartment < ApplicationRecord
  belongs_to :city
  belongs_to :borough, optional: true
  has_many :favorite_apartments, dependent: :destroy

  geocoded_by :address
  after_validation :geocode

  validates :address, presence: true
  validates :surface, presence: true
  validates :floor, presence: true
  validates :rooms, presence: true
  validates :bedrooms, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :description, presence: true
end
