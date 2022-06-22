class CreateApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :apartments do |t|
      t.string :name
      t.string :address
      t.string :status
      t.integer :rooms
      t.integer :surface
      t.boolean :balcony, default: false
      t.boolean :chimney, default: false
      t.boolean :elevator, default: false
      t.timestamps
    end
  end
end
