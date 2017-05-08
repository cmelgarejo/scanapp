class User < ApplicationRecord
  ROLES = %w[admin moderator author banned].freeze
  #has_secure_password
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  after_initialize :set_default_role, if: :new_record?
  after_initialize :set_default_company, if: :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :locations
  accepts_nested_attributes_for :locations, allow_destroy: true

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories

  def has_role?(name)
    roles.pluck(:name).member?(name.to_s)
  end

  def my_roles
    self.roles.map(&:name)
  end

  def my_categories
    self.categories.map(&:name)
  end

  def set_default_role
    self.roles ||= []
    role  = Role.find_by(name: 'user') || 'user'
    self.roles << role if !roles.include? role
  end

  def set_default_company
    self.company ||= Company.first
  end

  def admin?
    self.roles.include? 'admin'
  end

end
