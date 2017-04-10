class Company < ApplicationRecord
  has_many :users
  has_many :items
  has_paper_trail
end
