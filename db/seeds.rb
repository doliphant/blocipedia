require 'faker'

#create users
4.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all


#create wikis
13.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: false
  )
end
wikis= Wiki.all

user = User.first
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Dan Oli',
  email: 'danoliphant@mac.com',
  password: 'pewfortest',
  role: 'admin'
)

user = User.second
user.skip_reconfirmation!
user.update_attributes!(
  name: 'Premium User',
  email: 'premium@example.com',
  password: 'portfolio',
  role: 'premium'
)

user = User.third
user.skip_reconfirmation!
user.update_attributes!(
  name: 'public user',
  email: 'public@example.com',
  password: 'portfolio',
  role: 'public'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
