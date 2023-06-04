class CreateFlatCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :flat_categories do |t|
      t.references :category, null: false, foreign_key: true
      t.references :flat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
