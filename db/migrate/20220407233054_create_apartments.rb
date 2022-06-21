class CreateApartments < ActiveRecord::Migration[6.0]
  def change
    create_table :apartments do |t|
      t.string :name
      t.string :address
      t.string :status
      t.integer :rooms
      t.integer :surface

      t.timestamps
    end
  end
end
