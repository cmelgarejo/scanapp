class Item < ApplicationRecord
  scope :recently_updated, -> { where('updated_at >= ?', Date.today - 2.hours) }
  has_paper_trail
  belongs_to :company
  has_and_belongs_to_many :parents, inverse_of: :item,
                          join_table: 'item_relationships',
                          class_name: Item,
                          foreign_key: :item_id,
                          association_foreign_key: :parent_id,
                          uniq: true
  has_and_belongs_to_many :children, inverse_of: :item,
                          join_table: 'item_relationships',
                          class_name: Item,
                          foreign_key: :parent_id,
                          association_foreign_key: :item_id,
                          uniq: true

  #attr_accessor :attachments
  has_many :attachment
  accepts_nested_attributes_for :attachment, allow_destroy: true
  accepts_nested_attributes_for :parents, allow_destroy: true
  accepts_nested_attributes_for :children, allow_destroy: true

  has_many :item_categories, dependent: :destroy
  has_many :categories, through: :item_categories

  def my_categories
    self.categories.map(&:name)
  end

  def my_categories?(have_any_of_these)
    ap self.categories & have_any_of_these
    self if self.categories & have_any_of_these
  end
  # def extra_properties
  #   require 'json'
  #   JSON.parse(self.extra_properties)
  # end

end