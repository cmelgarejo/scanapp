class CreateItemRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :item_relationships, id: false do |t|
      t.references :item, type: :uuid, foreign_key: true, index: true
      t.references :parent, type: :uuid, foreign_key: { to_table: :items }
      t.timestamps
    end
  end
end
