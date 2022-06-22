class City < ApplicationRecord
  has_many :apartments, dependent: :destroy
  has_many :boroughs, dependent: :destroy
end
