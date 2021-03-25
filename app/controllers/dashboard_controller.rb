class DashboardController < ApplicationController
  def index
    @user = current_user
    @user_cocktails = @user.cocktails
    @cocktails = Cocktail.all
  end
end
