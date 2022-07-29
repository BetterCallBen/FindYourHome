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
      t.boolean :balcony, default: false

      t.timestamps
    end
  end
end
