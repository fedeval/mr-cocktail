class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.search(params[:search])
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @review = Review.new
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      @cocktail.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :search, :photo, :recipe)
  end
end
