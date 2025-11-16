class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
