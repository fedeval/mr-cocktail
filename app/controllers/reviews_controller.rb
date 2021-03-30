class ReviewsController < ApplicationController
  before_action :find_cocktail, only: [:create]

  def create
    @review = Review.new(review_params)
    @review.cocktail = @cocktail
    @review.user = current_user
    if @review.save
      @review.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'cocktails/show'
    end
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
