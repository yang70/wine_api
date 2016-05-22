# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_names = [
  "Hope",
  "Matt",
  "Ruby",
  "Aaron"
]

user_names.each do |name|
  User.create!(email: "#{name}@example.com", password: "password", password_confirmation: "password")
end

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

users = User.all

users.each_with_index do |user, user_index|
  wine_names.each_with_index do |wine, index|
    Wine.create!(name: user_names[user_index] + "'s " + wine, varietal: wine_varietal[index], quantity: 1, user: user)
  end
end

