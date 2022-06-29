class City < ApplicationRecord
  has_many :apartments, dependent: :destroy
  has_many :houses, dependent: :destroy
  has_many :boroughs, dependent: :destroy

  validates :name, presence: true
  validates :insee_code, presence: true, uniqueness: true
end
