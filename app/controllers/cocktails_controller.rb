class CocktailsController < ApplicationController
  before_action :find_cocktail, only: [:show, :edit, :destroy]

  def index
    @cocktails = Cocktail.search(params[:search])
  end

  def show
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

  def edit
    @doses = @cocktail.doses
  end

  def update; end

  def destroy
    @cocktail.destroy
    redirect_to dashboard_index_path
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :search, :photo, :recipe)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
