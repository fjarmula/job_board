class JobOffersController < ApplicationController
  allow_unauthenticated_access only: [ :index, :show ]
  skip_before_action :require_authentication, only: [ :new, :create ]

  before_action :authenticate_recruiter!, only: [ :new, :create ]
  before_action :set_job_offer, only: [ :show ]
  def index
    if current_recruiter
      @job_offers = JobOffer.where(recruiter: current_recruiter).order(created_at: :asc)
    else
      @job_offers = JobOffer.all.order(created_at: :asc)
    end
  end

  def show
    @job_offer = JobOffer.find(params[:id])
  end

  def new
    @job_offer = JobOffer.new
  end

  def create
    @job_offer = JobOffer.new(job_offer_params)
    @job_offer.recruiter = current_recruiter
    if @job_offer.save
      redirect_to @job_offer, notice: "Job offer was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def set_job_offer
      @job_offer = JobOffer.find(params[:id])
    end
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
