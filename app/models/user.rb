class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cocktails
  has_many :favorites
  
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end
end
