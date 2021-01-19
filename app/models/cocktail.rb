class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews

  validates :name, presence: true, uniqueness: true

  def self.search(search)
    if search
      where(["LOWER(name) LIKE ?", "%#{search['name'].downcase}%"])
    else
      all
    end
  end
end
