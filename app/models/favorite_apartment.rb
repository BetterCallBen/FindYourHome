class FavoriteApartment < ApplicationRecord
  belongs_to :apartment
  belongs_to :user

  validates :apartment, uniqueness: { scope: :user_id }
end
