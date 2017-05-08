class CreateUserLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :user
      t.text :country
      t.text :state
      t.text :city
      t.timestamps
    end
    add_index :locations, [:user_id, :country]
    add_index :locations, [:user_id, :country, :state]
    add_index :locations, [:user_id, :country, :state, :city]
  end
end
