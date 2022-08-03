class CreateFavoriteApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_apartments do |t|
      t.string :name
      t.references :apartment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
