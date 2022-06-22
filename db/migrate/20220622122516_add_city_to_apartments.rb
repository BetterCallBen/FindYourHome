class AddCityToApartments < ActiveRecord::Migration[6.0]
  def change
    add_reference :apartments, :city, null: false, foreign_key: true
  end
end
