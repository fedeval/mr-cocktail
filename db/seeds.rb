# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'

puts 'clean up db'
Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all
User.destroy_all

puts 'create test users'
User.create(email: 'federico@test.com', password: '123456')
User.create(email: 'christina@test.com', password: '123456')
User.create(email: 'ilaria@test.com', password: '123456')

puts 'generate ingredients'
ingredients_url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredients_response = open(ingredients_url).read
ingredients = JSON.parse(ingredients_response)
ingredients['drinks'].each { |ingredient| Ingredient.create!(name: ingredient['strIngredient1']) }

puts 'generate cocktails'
cocktails_url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail'
cocktails_response = open(cocktails_url).read
cocktails = JSON.parse(cocktails_response)

cocktails['drinks'].sample(20).each do |cocktail|
  new_cocktail = Cocktail.new(name: cocktail['strDrink'])
  thumbnail = URI.open(cocktail['strDrinkThumb'])
  new_cocktail.photo.attach(io: thumbnail, filename: 'nes.png', content_type: 'image/png')
  new_cocktail.save

  cocktail_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{cocktail['idDrink']}"
  cocktail_response = open(cocktail_url).read
  cocktail_info = JSON.parse(cocktail_response)
  
  ingredient_num = 1
  cocktail_info['drinks'].first.each do |key, value|
    if key.include?('strIngredient') && !value.nil?
      Dose.create(
        cocktail: new_cocktail,
        ingredient: Ingredient.find_by(name: value),
        description: cocktail_info['drinks'].first["strMeasure#{ingredient_num}"]
      )
      ingredient_num += 1
    end
  end
end

puts 'done'
