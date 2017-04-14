class Item < ApplicationRecord
  has_paper_trail
  alias_attribute :parents, :item
  belongs_to :company
  belongs_to :template, class_name: 'Item', foreign_key: 'item_id', optional: true
  has_and_belongs_to_many :item,
                          join_table: :item_relationships,
                          foreign_key: :item_id,
                          association_foreign_key: :parent_id
  #Carrierwave stuff
  #mount_uploader :picture, DocumentUploader
  has_many :documents
  attr_accessor :document_data

  def Properties
    require 'json'
    JSON.parse(self.properties)
  end

end