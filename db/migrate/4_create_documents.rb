class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.references :item, type: :uuid, foreign_key: true, index: true
      t.string :document

      t.timestamps
    end
  end
end