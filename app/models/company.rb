class Company < ApplicationRecord
  has_many :recruiters, dependent: :destroy
  has_many :job_offers, through: :recruiters

  validates :name, presence: true, uniqueness: true
  validates :headquarters, presence: true

  SIZES = %w[1-10 11-50 51-200 201-500 501-1000 1000+].freeze
  def super_recruiter
    recruiters.find_by(super_recruiter: true)
  end
end
