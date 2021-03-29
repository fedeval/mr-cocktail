class FavoritesController < ApplicationController
  before_action :find_cocktail, only: :create

  def create
    @favorite = Favorite.new(cocktail: @cocktail)
    @favorite.user = current_user
    if @favorite.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'cocktails/show'
    end
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end
end
