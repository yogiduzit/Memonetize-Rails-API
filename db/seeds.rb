# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UserTagging.delete_all
MemeTagging.delete_all
Tag.delete_all
User.destroy_all

NUM_USERS = 5
TAGS = ["funny", "star", "dankmemes", "memes", "meme", "dank", "memesdaily", "funny",
   "funnymemes", "edgymemes", "lol", "offensivememes", "dankmeme", "lmao", "edgy", "fortnite",
    "dailymemes", "anime", "minecraft", "follow", "comedy", "offensive", "cringe", "spicymemes",
     "humor", "like", "memestagram", "area", "dankmemesdaily", "tiktok", "funnyvideos", "bhfyp"]
NUM_MEMES = 20
NUM_COMMENTS = 6
NUM_VOTES = 2000
NUM_USER_TAGGINGS = 200
NUM_MEME_TAGGINGS = 200



LOREM_IPSUM = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

TAGS.each do |tag|
  Tag.create(
    name: tag
  )
end


User.create(
  first_name: "Yogesh", 
  last_name: "Verma",
  password: "yogi",
  email: "itsyog35h@gmail.com",
  is_admin: true,
)

i = 0
NUM_USERS.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    password: "supersecret",
    email: "#{first_name}-#{last_name}-#{i}@gmail.com"
  )
  i += 1
end

meme_counter = 1
NUM_MEMES.times do 
  filename = "meme-#{meme_counter}.png"
  meme_img = File.open(File.join(Rails.root, "app/assets/images/#{filename}"))
  meme = Meme.new(
    title: Faker::ChuckNorris.fact,
    body: LOREM_IPSUM,
    user: User.all.sample
  )
  meme.meme_img.attach(
    io: meme_img,
    filename: "#{filename}",
    content_type: 'application/png',
  )
  meme_counter += 1

  meme.save

  meme.comments = NUM_COMMENTS.times.map do 
    Comment.create(
      user: User.all.sample,
      body: Faker::Food.description,
      meme: meme
    )
  end
end

NUM_VOTES.times do 
  Vote.create(
    vote_type: '1',
    user: User.all.sample, 
    meme: Meme.all.sample
  )
end

NUM_USER_TAGGINGS.times do 
  UserTagging.create(
    user: User.all.sample,
    tag: Tag.all.sample
  )
end

NUM_MEME_TAGGINGS.times do 
  MemeTagging.create(
    meme: Meme.all.sample,
    tag: Tag.all.sample
  )
end

memes = Meme.count
users = User.count
comments = Comment.count
tags = Tag.count

p "Memes: #{memes} \n Users: #{users} \n Comments: #{comments} \n Tags: #{tags}"