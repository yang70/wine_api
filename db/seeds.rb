# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
wine_names = [
  "Wine 1",
  "Wine 2",
  "Wine 3"
]

wine_varietal = [
  "Cabernet Sauvignon",
  "Syrah",
  "Chardonnay"
]

wine_names.each_with_index do |wine, index|
  new_wine = Wine.new(name: wine, varietal: wine_varietal[index], quantity: 1)
  new_wine.save
end

