class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name, index: true
      t.string :description
      t.boolean :enabled

      t.timestamps
    end
  end
end
