class Image < ApplicationRecord
  belongs_to :product
  mount_uploader :picture, PictureUploader
end
