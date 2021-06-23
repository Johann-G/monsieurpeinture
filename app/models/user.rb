class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :set_same_password
  before_validation :set_same_password_confirmation

  has_many :todos

  def set_same_password
    self.password = "password"
  end

  def set_same_password_confirmation
    self.password_confirmation = "password"
  end

  private

  def password_required?
    return false
  end
end
