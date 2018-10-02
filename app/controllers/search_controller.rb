class SearchController < ApplicationController
	def index
	end

	def searching
		@listing = Listing.where(nil)
		filtering_params.each do |key, value|
			@listing = @listing.public_send(key,value) if value.present?
		end
		@listing = @listing.min_price(params[:min]) if params[:min].present?
		@listing = @listing.max_price(params[:max]) if params[:max].present?

		render "show"
	end

	def show
	end


	# Not used but act as reference for future improvement
	def search
		@listings = Listing.where("city ILIKE ?", params[:query])
	end

	private
	def filtering_params
		params.slice(:country, :state, :city, :guest_number, :bed_number, :room_number, :bath_number)
	end

	def full_filtering_params
		params.slice(:country, :state, :city, :guest_number, :bed_number, :room_number, :bath_number, :min, :max)
	end
end

