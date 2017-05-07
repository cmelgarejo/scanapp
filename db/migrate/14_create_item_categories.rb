class CreateItemCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :item_categories do |t|
      t.references :item, type: :uuid, foreign_key: true
      t.references :category
      t.timestamps
    end
    add_index :item_categories, [:item_id, :category_id], unique: true
  end
end
