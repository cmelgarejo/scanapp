class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items, id: :uuid do |t|
      t.text :label
      t.text :description
      t.text :qrcode
      t.text :color_reference
      t.string :picture
      t.float :lat
      t.float :lon
      t.boolean :enabled, default: true
      t.boolean :is_template, default: false
      t.boolean :is_root, default: false
      t.jsonb :properties
      t.references :company, foreign_key: true, index: true
      t.references :item, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
  end
end
