# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# ["Admin", "Moderator", "Author"].each do |role|
#   Role.find_or_create_by_name role
# end

# admin = User.find_by_username("admin")
# unless admin
#   admin = User.create(:username => "admin", :email => "admin@example.com", :password => "secret", :password_confirmation => "secret")
#   admin.confirm!
# end
# 
# [Post, Comment, Tagging, Tag].each do |model|
#   model.delete_all
# end
# 
# require 'faker'
# 
# 50.times do |i|
#   Post.create(
#     :title => Faker::Lorem.sentence.titleize,
#     :body => Faker::Lorem.paragraphs.join("<br/>"),
#     :user => admin,
#     :tag_list => Faker::Lorem.words(5).join(','),
#     :created_at => Date.civil((2008..2010).to_a.rand, (1..12).to_a.rand, (1..28).to_a.rand)
#   )
# end

require File.expand_path(File.dirname(__FILE__) + '/blueprints')

[User, Post, Tag].each do |model|
  model.delete_all
end

admin = User.make(:username => "admin")
user = User.make(:username => "user")

50.times do |i|
  [user, admin].each do |u|
    post = Post.make(:user => u)
    (1..10).to_a.rand.times do |i|
      post.comments.make
    end
  end
end
