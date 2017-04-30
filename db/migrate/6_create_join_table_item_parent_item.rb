class CreateJoinTableItemParentItem < ActiveRecord::Migration[5.0]
  def change
    create_table :item_relationships, id: false do |t|
      t.uuid :item_id, null: false, index: true
      t.uuid :parent_id, null: false, index: true
      t.timestamps
    end
  end
end
