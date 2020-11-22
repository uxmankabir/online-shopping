class Product < ApplicationRecord

  enum status: [:pending, :rejected, :approved]

  belongs_to :user
  has_many :images
  accepts_nested_attributes_for :images
end
