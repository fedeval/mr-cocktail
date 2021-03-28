class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_many :reviews, dependent: :destroy

  has_one_attached :photo

  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :photo, presence: true
  validates :recipe, presence: true

  def self.search(search)
    if search
      where(["LOWER(name) LIKE ?", "%#{search['name'].downcase}%"])
    else
      all
    end
  end

  def average_review_rating
    @ratings = reviews.map { |review| review.rating.to_f }
    return 0 if @ratings.nil?

    @ratings.reduce(0) { |avg, curr_rating| avg + (curr_rating / reviews.length) }
  end

  def favorite?(user)
    user_favorite_cocktails = user.favorites.map { |favorite| favorite.cocktail }
    user_favorite_cocktails.include? self
  end
end
