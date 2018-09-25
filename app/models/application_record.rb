class ApplicationRecord < ActiveRecord::Base
	mount_uploader :image_profile, AvatarUploader
  self.abstract_class = true
end
