class User < ApplicationRecord
  include Clearance::User


  mount_uploader :image_profile, AvatarUploader
  
  has_many :authentications, dependent: :destroy
  has_many :listings
  has_many :reservations

  def self.create_with_auth_and_hash(authentication, auth_hash)
  	user = self.create!(
  		username: auth_hash["info"]["username"],
  		email: auth_hash["info"]["email"],
  		password: SecureRandom.hex(10)
  	)
  	user.authentications << authentication
  	return user
  end

  def google_token
  	x = self.authentications.find_by(provider: 'google_oauth2')
  	return x.token unless x.nil?
  end
end
