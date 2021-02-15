# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.logger = nil
ActiveRecord::Base.connection.execute("TRUNCATE recipes RESTART IDENTITY")
ActiveRecord::Base.connection.execute("TRUNCATE ingredients RESTART IDENTITY")

records = File.open("./db/seeds/recipes.json").read
bulk_recipes = []
bulk_ingredients = []

records.each_line.with_index(1) do |record, id|
    parsed = JSON.parse(record)
    bulk_recipes << parsed.except('ingredients').merge({id: id})

    parsed['ingredients'].each do |ingredient|
        bulk_ingredients << {
            recipe_id: id,
            ingredient: ingredient
        }
    end

    rescue JSON::ParserError => e
        next
end

Recipe.insert_all(bulk_recipes)
Ingredient.insert_all(bulk_ingredients)
puts "#{Recipe.count} recipes saved"
puts "#{Ingredient.count} ingredients saved"