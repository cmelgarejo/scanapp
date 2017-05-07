class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items, id: :uuid do |t|
      t.text :label, index: true
      t.text :description, index: true
      t.text :color_reference
      t.text :country, index: true
      t.text :state
      t.text :city
      t.float :lat
      t.float :lng
      t.boolean :enabled, default: true
      t.boolean :is_template, default: false
      t.boolean :is_root, default: false
      t.jsonb :extra_properties
      t.references :company, foreign_key: true, index: true
      #t.references :item, type: :uuid, foreign_key: true, index: true

      t.timestamps
    end
    execute 'CREATE INDEX index_items_latlng_spgist ON items USING spgist(point(lat, lng));'
    #SELECT *
    # FROM   point
    # WHERE  '(47.606977, -122.232991), (47.506977, -122.338991)'::box
    # @> point(lat, lng);
    add_index :items, :color_reference
    add_index :items, [:country, :state]
    add_index :items, [:country, :state, :city]
  end
end
