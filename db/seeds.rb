# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
50.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      u = User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
                   puts 'New user created: ' << u.name
    end
User.all.each do |user|
  6.times do |n|
    user.articles.create!(:name => "The name #{n+1}",
    :content => Faker::Lorem.sentence(5))
  end
end