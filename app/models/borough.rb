class Borough < ApplicationRecord
  belongs_to :city

  validates :name, presence: true
  validates :insee_code, presence: true, uniqueness: true

  has_many :research_boroughs, dependent: :destroy
end
