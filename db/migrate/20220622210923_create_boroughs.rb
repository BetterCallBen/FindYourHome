class CreateBoroughs < ActiveRecord::Migration[6.0]
  def change
    create_table :boroughs do |t|
      t.string :name
      t.string :insee_code
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
