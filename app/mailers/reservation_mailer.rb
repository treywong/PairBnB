class ReservationMailer < ApplicationMailer
	default from: 'notifications@example.com'

	def booking_email(reservation_id)
		reservation = Reservation.find_by(id: reservation_id)
		@customer = reservation.user
		@host = reservation.listing.user
		@listing = reservation.listing
		mail( to: @customer.email, subject: "You're going to #{@listing.name}")
	end
end
