class Research < ApplicationRecord
  belongs_to :user
  belongs_to :city, optional: true
  belongs_to :borough, optional: true

  has_many :research_boroughs, dependent: :destroy
  has_many :research_cities, dependent: :destroy
end
