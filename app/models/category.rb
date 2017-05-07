class Category < ApplicationRecord
  has_many :item_categories, dependent: :destroy
  has_many :item, through: :item_categories
  has_many :user_categories, dependent: :destroy
  has_many :user, through: :user_categories
end