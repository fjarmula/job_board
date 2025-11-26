class Company < ApplicationRecord
  has_many :recruiters
  has_many :job_offers, through: :recruiters

  validates :name, presence: true
end
