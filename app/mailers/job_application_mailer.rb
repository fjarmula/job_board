class JobApplicationMailer < ApplicationMailer
  default from: "no-reply@jobboard.com"

  def job_application_confirmation(job_application)
    @job_application = job_application
    @user = @job_application.user
    @job_offer = @job_application.job_offer

    mail(to: @user.email_address, subject: "You applied for #{@job_offer.position}")
  end
end
