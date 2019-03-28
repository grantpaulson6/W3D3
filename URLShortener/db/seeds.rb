# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  ShortenedUrl.destroy_all

  User.destroy_all
  
  grant = User.create!(email: "grant@gmail")

  ShortenedUrl.make(grant, "ggggggggggggggggggggggggggggggg")

  ShortenedUrl.make(grant, "rrrrrrrrrrrrrrrrrrrrrrrrrrrrarrar")

  visit1 = grant.shorten_url('aaaaaaaaaaaaaaaaaaaaaaaaa')

  andrew = User.create!(email: "andrew@yahoo")

  visit2 = andrew.shorten_url('nnnnnnnnnnnnnnnnnnnnnnnnn')

  Visit.record_visit!(andrew, visit1)

  Visit.record_visit!(grant, visit1)
  Visit.record_visit!(andrew, visit1)

end


