class AddRecipeToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :recipe, :text
  end
end
