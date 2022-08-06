class CreateFavoriteApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_apartments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :apartment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
