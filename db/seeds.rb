# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(email: 'salman@selecta.com', password: '123')
User.create(email: 'michael@selecta.com', password: '123')
User.create(email: 'alex@selecta.com', password: '123')
User.create(email: 'faisal@selecta.com', password: '123')

Song.create(soundcloud_id: 1)
Song.create(soundcloud_id: 2)
Song.create(soundcloud_id: 3)
Song.create(soundcloud_id: 4)
Song.create(soundcloud_id: 5)
Song.create(soundcloud_id: 6)
Song.create(soundcloud_id: 7)
Song.create(soundcloud_id: 8)
Song.create(soundcloud_id: 9)
Song.create(soundcloud_id: 10)
Song.create(soundcloud_id: 31252572)
Song.create(soundcloud_id: 27580789)

User.all.each {|user| user.songs << Song.find_by(soundcloud_id: 31252572)}

User.find(2,3,4).each {|user| user.songs << Song.find_by(soundcloud_id:27580789)}

Song.find(2,3,4,5).each{|song| User.find(1).songs << song}
Song.find(7,4,10).each{|song| User.find(3).songs << song}
Song.find(8,9).each{|song| User.find(4).songs << song}
