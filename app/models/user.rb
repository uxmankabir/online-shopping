class User < ApplicationRecord
  before_create :lower_case

  enum role: [:admin, :buyer, :seller]
  has_secure_password

  has_many :products
  has_many :favourites
  has_many :carts

  validates :role, presence: true,
    inclusion: { in: ["admin", "buyer", "seller"] , message: " is not valid." }
    
  validates :email, uniqueness: { case_sensitive: false },
    format: { with: /\A[a-zA-Z0-9_.@]+\z/, message: "special characters are not allowed." }

  validates :first_name, :last_name, presence: true,
    format: { with: /\A[a-zA-Z0-9_ ]+\z/, message: "special characters are not allowed." },
    length: { in: 4..20 }

  validates :password, presence: true, length: { minimum: 6 }, if: :password.present?
    
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  private
  def lower_case
    self.email.downcase!
  end
end
