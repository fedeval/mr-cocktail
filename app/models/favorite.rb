class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :cocktail

  validates :user, uniqueness: { scope: :cocktail }
end
