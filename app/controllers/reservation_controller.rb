class ReservationController < ApplicationController
	def new
		@reservation = Reservation.new
	end

	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		@reservation.listing_id = params[:id]
		@reservation.save
		redirect_to reservation_path
	end

	def index
		@reservation = Reservation.all.where(user_id: current_user.id)
	end

	private
		def reservation_params
			params.require(:reservation).permit(:date_start, :date_end)
		end
end
