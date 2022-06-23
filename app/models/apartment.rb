class Apartment < ApplicationRecord
  belongs_to :city

  validates :name, presence: true
  validates :address, presence: true
  validates :surface, presence: true
  validates :rooms, presence: true
  validates :status, presence: true
  validates :borough_id, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: { only_integer: true }
  validates :apartment_type, presence: true, inclusion: { in: %w[flat house] }
  validates :description, presence: true
end
