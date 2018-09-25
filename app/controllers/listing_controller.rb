class ListingController < ApplicationController
	def new
		@listing = Listing.new
	end

	def create
		@listing = Listing.new(listing_params)
		@listing.user_id = current_user.id
		@listing.save

		redirect_to root_path
	end

	def show
		@listing = Listing.find_by(id: params[:id])
	end

	def index
		@listing = Listing.order(:name).page params[:page]
	end

	def edit
		@listing = Listing.find_by(id: params[:id])
	end

	def update
		@listing = Listing.find_by(id: params[:id])
		@listing.update(listing_params)
		@listing.save

		redirect_to "/listing/#{params[:id]}"
	end

	def delete
		@listing = Listing.find_by(id: params[:id])
		@listing.destroy
		redirect_to root_path
	end

	private
	def listing_params
		params.require(:listing).permit(:name,:address,:price,:detail,:guest_number,:bed_number,:room_number,:bath_number)
	end
end
