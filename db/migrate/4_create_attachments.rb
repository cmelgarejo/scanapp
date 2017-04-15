class CreateAttachments< ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :item, type: :uuid, foreign_key: true, index: true
      t.string :path

      t.timestamps
    end
  end
end
