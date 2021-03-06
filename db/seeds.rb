# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.create!(
#   email: "test@example.com",
#   password: "testpass",
#   name: "ゲスト",
#   description: "はじめまして、気ままに投稿していきます！フォローお願いします！",
#   profile_image:File.open("./public/images/guest.jpg")
# )

15.times do |i|
  Like.create!(
    song_id: 4,
    user_id: i + 1
  )
end

20.times do |i|
  Like.create!(
    song_id: 2,
    user_id: i + 1
  )
end

25.times do |i|
  Like.create!(
    song_id: 3,
    user_id: i + 1
  )
end

10.times do |i|
  Relationship.create!(
    user_id: 1,
    follow_id: i + 2
  )
end
10.times do |i|
  Relationship.create!(
    user_id: i + 2,
    follow_id: 1
  )
end
