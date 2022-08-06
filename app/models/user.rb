class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :researches, dependent: :destroy
  has_many :favorite_apartments, dependent: :destroy
  has_many :favorite_houses, dependent: :destroy
end
