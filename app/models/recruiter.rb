class Recruiter < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  has_many :job_offers, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :company_name, presence: true
end
