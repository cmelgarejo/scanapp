class User < ApplicationRecord
  ROLES = %w[admin moderator author banned].freeze
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

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles

  def has_role?(name)
    roles.pluck(:name).member?(name.to_s)
  end

  def my_roles
    self.roles.map(&:name)
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
