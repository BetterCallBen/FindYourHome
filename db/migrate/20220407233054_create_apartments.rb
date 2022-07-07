class CreateApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :apartments do |t|
      t.string :project
      t.string :name
      t.text :description
      t.text :image_url
      t.string :address
      t.string :status
      t.integer :floor
      t.integer :price
      t.integer :rooms
      t.integer :surface
      t.boolean :balcony, default: false
      t.boolean :chimney, default: false
      t.boolean :elevator, default: false
      t.boolean :cellar, default: false
      t.boolean :garage, default: false
      t.boolean :terrace, default: false
      t.timestamps
    end
  end
end
