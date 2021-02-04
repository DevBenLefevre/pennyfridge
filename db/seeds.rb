# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

records = File.open("./storage/recipes.json").read
bulk_array = []

records.each_line do |record|
    parsed = JSON.parse(record)
    bulk_array << parsed
    rescue JSON::ParserError => e
        next
end

Recipe.insert_all(bulk_array)
puts "#{Recipe.count} recipes saved"