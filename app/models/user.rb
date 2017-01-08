class User < ActiveRecord::Base
  has_many :contact_forms
  has_many :reviews
  has_secure_password

  # Validations

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :first_name, :last_name, length: { in: 2..20 }
end
