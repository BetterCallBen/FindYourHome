class Borough < ApplicationRecord
  belongs_to :city

  validates :name, presence: true
  validates :insee_code, presence: true, uniqueness: true
end
