require 'machinist/active_record'
require 'sham'
require 'faker'

Sham.username { Faker::Internet.user_name }
Sham.email    { Faker::Internet.email }
Sham.title    { Faker::Lorem.sentence }
Sham.body     { Faker::Lorem.paragraph }
Sham.name     { Faker::Name.name }
# Sham.date     { Date.civil((2006...2009).to_a.rand, (1..12).to_a.rand, (1..28).to_a.rand) }

Sham.datetime { Time.at(rand(3600 * 24 * 365) + 1.year.ago.to_i) }


User.blueprint do
  username
  email
  password "secret"
  password_confirmation password
  confirmed_at Time.now
end

Post.blueprint do
  title
  user
  body
  tag_list    { Faker::Lorem.words(5).join(',') }
  created_at  { Sham.datetime }
end

Comment.blueprint do
  commentable { post }
  author_name { Sham.name }
  body
  created_at  { commentable.created_at + rand(200) * 3600 }
end
