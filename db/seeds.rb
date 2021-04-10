require 'open-uri'
require 'json'

puts 'clean up db'
Ingredient.destroy_all
Cocktail.destroy_all
Dose.destroy_all
User.destroy_all

puts 'create test users'
User.create(email: 'federico@test.com', password: '123456', first_name: 'Federico', last_name: 'Valenza')
User.create(email: 'christina@test.com', password: '123456', first_name: 'Christina', last_name: 'Koufopoulou')
User.create(email: 'ilaria@test.com', password: '123456', first_name: 'Ilaria', last_name: 'Valenza')

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
  new_cocktail = Cocktail.new(name: cocktail['strDrink'], user: User.all.sample)
  thumbnail = URI.open(cocktail['strDrinkThumb'])
  new_cocktail.photo.attach(io: thumbnail, filename: 'nes.png', content_type: 'image/png')

  cocktail_url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=#{cocktail['idDrink']}"
  cocktail_response = open(cocktail_url).read
  cocktail_info = JSON.parse(cocktail_response)

  new_cocktail.recipe = cocktail_info['drinks'].first['strInstructions'].strip
  new_cocktail.save

  ingredient_num = 1
  cocktail_info['drinks'].first.each do |key, value|
    if key.include?('strIngredient') && !value.nil?
      dose = Dose.new(
        ingredient: Ingredient.find_by(name: value.strip) || Ingredient.create(name: value.strip),
        description: cocktail_info['drinks'].first["strMeasure#{ingredient_num}"]
      )
      dose.cocktail = new_cocktail
      dose.save
      ingredient_num += 1
    end
  end
end

puts 'done'
