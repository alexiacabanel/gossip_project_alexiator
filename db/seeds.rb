# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
City.destroy_all
require 'faker'

cities = []
10.times do
  city = City.create!(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
  cities << city
end

10.times do
    user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence, email: Faker::Internet.email, age: Faker::Number.within(range: 18..100), city_id: cities[rand(0..9)].id)
end

20.times do
    gossip = Gossip.create!(title: Faker::Hipster.sentence(word_count: 3, supplemental: true), content: Faker::ChuckNorris.fact, user_id: User.all.shuffle.last.id)
end

10.times do
    tag = Tag.create!(title: Faker::Hipster.word)
end

20.times do
    gossiptag = GossipsTag.create!(gossip_id: Gossip.all.shuffle.last.id, tag_id: Tag.all.shuffle.last.id)
end

20.times do
    pm = PrivateMessage.create!(content: Faker::ChuckNorris.fact, recipient_id: User.all.shuffle.last.id, sender_id: User.all.shuffle.last.id)
end