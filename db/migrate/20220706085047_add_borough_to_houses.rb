class AddBoroughToHouses < ActiveRecord::Migration[6.0]
  def change
    add_reference :houses, :borough, null: true, foreign_key: true
  end
end
