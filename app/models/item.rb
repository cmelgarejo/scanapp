class Item < ApplicationRecord
  has_paper_trail
  alias_attribute :parents, :item
  belongs_to :company
  belongs_to :template, class_name: 'Item', foreign_key: 'item_id', optional: true
  has_and_belongs_to_many :item,
                          join_table: 'item_relationships',
                          foreign_key: :item_id,
                          association_foreign_key: :parent_id
  #attr_accessor :attachments
  has_many :attachment
  accepts_nested_attributes_for :attachment, :allow_destroy => true

  # def extra_properties
  #   require 'json'
  #   JSON.parse(self.extra_properties)
  # end
end