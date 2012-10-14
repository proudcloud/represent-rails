# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

puts "Creating default user..."

User.create! email: "admin@user.com", 
             password: "letmein", 
             password_confirmation: "letmein"

puts "Default user created!"

puts "Creating startups..."

3.times do |i|
  i += 1

  Place.create! type: "startup",
                owner_name: "Startup Owner #{i}", 
                owner_email: "startup#{i}1@user.com", 
                title: "Startup #{i}",
                description: "Startup #{i}",
                address: "Random Address",
                uri: "http://www.startup#{i}.com",
                lat: "121.0#{i}0967".to_f,
                lng: 14.646123,
                approved: true
end

