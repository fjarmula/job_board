class JobOffersController < ApplicationController
  def index
    @job_offers = JobOffer.order(created_at: :asc)
  end

  def show
    @job_offer = JobOffer.find(params[:id])
  end

  def new
    @job_offer = JobOffer.new
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    if @job_offer.save
      redirect_to @job_offer, notice: "Job offer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def job_offer_params
      params.require(:job_offer).permit(
        :company_name,
        :position,
        :location,
        :work_mode,
        :work_dimension,
        :employment_type,
        :experience_level,
        :salary_min,
        :salary_max,
        :description,
        :tech_stack
      )
    end
end
