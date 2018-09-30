class ReservationController < ApplicationController
	def new
		@reservation = Reservation.new
	end

	def create

		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:id]
		if @reservation.save
			redirect_to bookings_confirm_path(@reservation.id)
		else
			redirect_to reservation_path, :flash => { :error => "Booking failed!"}


		end
	end

	def edit
		@reservation = Reservation.find_by(listing_id: params[:id])
	end

	def update
		@reservation = Reservation.find_by(listing_id: params[:id])
		@reservation.update(reservation_params)
		@reservation.total_price = (@reservation.date_end - @reservation.date_start) * @reservation.listing.price
		@reservation.save

		redirect_to reservation_path
	end

	def delete
		@reservation = Reservation.find_by(id: params[:id])
		@reservation.destroy
		redirect_to reservation_path
	end

	def index
		@reservation = Reservation.all.where(user_id: current_user.id)
	end

	private
		def reservation_params
			params.require(:reservation).permit(:date_start, :date_end, :guest)
		end
end
