class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company
  enum role: [:admin, :user]
  after_initialize :set_default_role, if: :new_record?
  after_initialize :set_default_company, if: :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_paper_trail

  def set_default_role
    self.role ||= :user
  end

  def set_default_company
    self.company ||= Company.first
  end

  def admin?
    self.role == :admin
  end
end
