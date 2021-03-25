class DashboardController < ApplicationController
  def index
    @user = current_user
    @user_cocktails = @user.cocktails
  end
end
