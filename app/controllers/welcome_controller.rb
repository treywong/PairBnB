class WelcomeController < ApplicationController
  before_action :require_login

  def index
  	@listings = Listing.all.where(user_id: current_user.id).order(:name).page params[:page]
  end
end
