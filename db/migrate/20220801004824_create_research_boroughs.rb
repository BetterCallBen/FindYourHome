class CreateResearchBoroughs < ActiveRecord::Migration[6.0]
  def change
    create_table :research_boroughs do |t|
      t.references :borough, null: false, foreign_key: true
      t.references :research, null: false, foreign_key: true

      t.timestamps
    end
  end
end
