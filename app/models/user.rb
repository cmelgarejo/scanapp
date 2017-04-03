class User < ApplicationRecord
  belongs_to :company
  enum role: [:admin, :user]
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_company, :if => :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :user
  end

  def set_default_company
    self.company ||= Company.first
  end

end
