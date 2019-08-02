# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


MEMES = [
        "https://images.unsplash.com/photo-1508138221679-760a23a2285b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1485550409059-9afb054cada4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60", 
        "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"
      ]

NUM_USERS = 10
NUM_PRO_USERS = 10
NUM_MODS = 5
i = 0
NUM_MEMES = 200

User.destroy_all

User.create(
  first_name: "Yogesh", 
  last_name: "Verma",
  password: "yogi",
  email: "itsyog35h@gmail.com",
  is_admin: true
)

NUM_USERS.times do 
  
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    password: "supersecret",
    email: "#{first_name}-#{last_name}-#{i}@gmail.com"
  )
end

users = User.all

NUM_MEMES.times do 
  meme_img = File.open(File.join(Rails.root, "app/assets/images/u-mad-logo.jpg"))
  meme = Meme.new(
    title: "Hahaha",
    body: Faker::ChuckNorris.fact,
    user: users.sample
  )
  meme.meme_img.attach(
    io: meme_img,
    filename: 'u-mad-logo.jpg'
  )
  meme.save
end



memes = Meme.all

p "Created #{users.count} users and #{memes.count} memes"