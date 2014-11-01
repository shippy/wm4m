# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Devise set-up
# user = CreateAdminService.new.call
# puts 'CREATED ADMIN USER: ' << user.email

# Create contacts and data for every existing user
User.all.each do |u|
  2.times { FactoryGirl.create(:contact, user: u) }

  # Data for last week
  7.times do |i|
    FactoryGirl.create(:response, user: u, datetime: (i.day.ago + rand(1..23).hour).to_datetime)
  end
end


