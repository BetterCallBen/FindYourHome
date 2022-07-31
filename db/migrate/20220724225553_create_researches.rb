class CreateResearches < ActiveRecord::Migration[6.0]
  def change
    create_table :researches do |t|
      t.references :user, null: false, foreign_key: true
      t.references :city, null: true, foreign_key: true
      t.references :borough, null: true, foreign_key: true
      t.text :link
      t.string :types
      t.string :rooms
      t.string :bedrooms
      t.string :project
      t.string :type
      t.string :locations
      t.string :status
      t.string :ground_floor
      t.boolean :balcony, default: false
      t.boolean :chimney, default: false
      t.boolean :pool, default: false
      t.boolean :garden, default: false
      t.boolean :cellar, default: false
      t.boolean :garage, default: false
      t.boolean :terrace, default: false



      t.timestamps
    end
  end
end
