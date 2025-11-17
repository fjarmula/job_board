class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job_offer

  validates :user_id, uniqueness: { scope: :job_offer_id, message: "has already applied for this job offer" }

  after_create :send_notification_email

  private
    def send_notification_email
      JobApplicationMailer.job_application_confirmation(self).deliver_later
    end
end
