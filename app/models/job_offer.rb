class JobOffer < ApplicationRecord
  validates :position, :location, :work_mode, :work_dimension, :experience_level, :employment_type, presence: true
  validates :salary_min, :salary_max, numericality: { allow_nil: true }
  validate :salary_range_valid

  belongs_to :recruiter
  has_many :job_applications, dependent: :destroy
  has_many :applicants, through: :job_applications, source: :user
  delegate :company, to: :recruiter

  enum :work_mode, { onsite: 0, remote: 1, hybrid: 2 }
  enum :work_dimension, { full_time: 0, part_time: 1, internship: 2 }
  enum :employment_type, { employment_contract: 0, mandate_contract: 1, b2b: 2, other: 4 }
  enum :experience_level, { junior: 0, mid_level: 1, senior: 2 }


  scope :by_company, ->(name) {
    if name.present?
      joins(recruiter: :company).where("companies.name ILIKE ?", "%#{name}%")
    else
      all
    end
  }

  scope :by_position, ->(position) {
    where("position ILIKE ?", "%#{position}%") if position.present?
  }

  scope :by_experience, ->(level) {
    where(experience_level: level) if level.present?
  }

  scope :by_work_mode, ->(mode) {
    where(work_mode: mode) if mode.present?
  }

  scope :by_location, ->(location) {
    where("location ILIKE ?", "%#{location}%") if location.present?
  }

  def self.search_and_filter(search_params)
    return all unless search_params.present?

    all
      .by_company(search_params[:company])
      .by_position(search_params[:position])
      .by_experience(search_params[:experience_level])
      .by_work_mode(search_params[:work_mode])
      .by_location(search_params[:location])
  end

  private
    def salary_range_valid
      if (salary_min.present? && salary_max.present?) && (salary_min > salary_max)
        errors.add(:salary_min, "must be less than or equal to salary_max")
      end
    end
end
