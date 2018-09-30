class BookingsController < ApplicationController
	def create
		@listing = Listing.find(params[:reservation][:listing_id])
		if @listing.is_available?(params[:reservation][:date_start], params[:reservation][:date_end])
			@reservation = @listing.bookings.new(reservation_params)
			@reservation.user = current_user
			if @reservation.save
				redirect_to new_booking_braintree_path(@reservation), notice: "Please complete payment to finalize booking."
			else
				redirect_to listing_path(@listing), notice: "Sorry, there was an issue confirming your booking."
			end
		else
			redirect_to listing_path(@listing), notice: "Sorry, the listing isn't available for your dates."
		end
	end

	def confirmation
		@reservation = Reservation.find_by(id: params[:id])
		if @reservation
			ReservationMailer.booking_email(@reservation.id).deliver_now
			notice = "Congratulations, you're going to #{@reservation.listing.city}!"
		else
			notice = "There was an issue with your payment, please try again."
		end
		redirect_to reservation_path, notice: notice
	end

	private
		def reservation_params
			params.require(:reservation).permit(:date_start, :date_end, :guest)
		end
end