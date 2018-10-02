class Listing < ApplicationRecord
  belongs_to :user
  has_many :reservations

  scope :country, -> (country) { where country: country }
  scope :state, -> (state) { where state: state }
  scope :city, -> (city) { where city: city }

  scope :guest_number, -> (guest_number) { where guest_number: guest_number }
  scope :bed_number, -> (bed_number) { where bed_number: bed_number }
  scope :room_number, -> (room_number) { where room_number: room_number }
  scope :bath_number, -> (bath_number) { where bath_number: bath_number }
  scope :min_price, -> (min) { where ("price > ?"), min }
  scope :max_price, -> (max) { where ("price < ?"), max }
end
