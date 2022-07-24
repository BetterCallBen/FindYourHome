class Research < ApplicationRecord
  belongs_to :user
  belongs_to :city, optional: true
  belongs_to :borough, optional: true
end
