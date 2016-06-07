# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


50.times do
 # #1
   Wiki.create!(
 # #2
     title:  Faker::Hipster.word,
     body:   Faker::Hipster.paragraph
   )
 end
 wikis = Wiki.all
 
 
 puts "Seed finished"
 puts "#{Wiki.count} wikis created"
