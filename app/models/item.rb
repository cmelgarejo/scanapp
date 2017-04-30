class Item < ApplicationRecord
  has_paper_trail
  belongs_to :company
  has_and_belongs_to_many :parents,
                          join_table: 'item_relationships',
                          foreign_key: :item_id,
                          association_foreign_key: :parent_id, class_name: 'Item'
  #attr_accessor :attachments
  has_many :attachment
  accepts_nested_attributes_for :attachment, allow_destroy: true
  accepts_nested_attributes_for :parents, allow_destroy: true

  # def extra_properties
  #   require 'json'
  #   JSON.parse(self.extra_properties)
  # end
end