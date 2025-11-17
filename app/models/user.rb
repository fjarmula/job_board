class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :applied_jobs, through: :job_applications, source: :job_offer

  validates :email_address,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :password,
            presence: true,
            length: { minimum: 6 }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
