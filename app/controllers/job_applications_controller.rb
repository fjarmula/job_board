class JobApplicationsController < ApplicationController
  def create
    job_offer = JobOffer.find(params[:job_offer_id])
    application = Current.user.job_applications.new(job_offer: job_offer)

    if application.save
      redirect_to job_offer_path(job_offer), notice: "Application submitted successfully."
    else
      redirect_to job_offer_path(job_offer), alert: application.errors.full_messages.to_sentence
    end
  end
end
