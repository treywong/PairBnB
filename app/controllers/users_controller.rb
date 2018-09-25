class UsersController < Clearance::UsersController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			redirect_back_or url_after_create
		else
			render template: "users/new"
		end
	end

	def edit
		@user = User.find_by(id: params[:id])
	end

	def update
		@user = User.find_by(id: params[:id])
		@user.update(user_params)
		@user.save

		redirect_to root_path
	end

	private
		def user_params
			params.require(:user).permit(:email, :image_profile, :username)
		end
end