class CreateResearchCities < ActiveRecord::Migration[6.0]
  def change
    create_table :research_cities do |t|
      t.references :city, null: false, foreign_key: true
      t.references :research, null: false, foreign_key: true

      t.timestamps
    end
  end
end
