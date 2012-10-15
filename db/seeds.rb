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
