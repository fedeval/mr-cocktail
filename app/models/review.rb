class Review < ApplicationRecord
  belongs_to :cocktail
  belongs_to :user

  validates :content, presence: true
  validates :rating, inclusion: { in: 1..5 }, presence: true
  validates :user, presence: true, uniqueness: { scope: :cocktail }
end
