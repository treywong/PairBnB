# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}
user['password'] = 'asdf'
image_box = Dir.glob("app/assets/images/*.jpg")
ActiveRecord::Base.transaction do
	20.times do
		user['username'] = Faker::Name.name
		user['email'] = Faker::Internet.email
		user['role'] = ['admin','moderator','customer'].sample
		user['image_profile'] = image_box.sample

		User.create(user)
	end
end

listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
	40.times do
		listing['name'] = Faker::App.name
		listing['address'] = Faker::Address.full_address
		listing['price'] = Faker::Number.decimal(3,2)
		listing['detail'] = Faker::Hipster.paragraph

		listing['guest_number'] = rand(1..10)
		listing['bed_number'] = rand(1..7)
		listing['room_number'] = rand(0..5)
		listing['bath_number'] = rand(0..3)
		
		listing['user_id'] = uids.sample

		Listing.create(listing)
	end
end