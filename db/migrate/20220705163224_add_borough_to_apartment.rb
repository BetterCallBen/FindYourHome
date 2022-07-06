class AddBoroughToApartment < ActiveRecord::Migration[6.0]
  def change
    add_reference :apartments, :borough, null: true, foreign_key: true
  end
end
