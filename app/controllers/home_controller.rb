class HomeController < ApplicationController
  allow_unauthenticated_access
  helper_method :search_params_present?, :active_filters
  def index
    @job_offers = JobOffer.all

    if params[:search].present? && search_params_present?(params[:search])
      @job_offers = filter_job_offers(@job_offers, params[:search])
    end

    @job_offers = @job_offers.order(created_at: :desc)
  end


  private

    def search_params_present?(search_params)
      search_params.values.any?(&:present?)
    end
    def active_filters
      filters = []

      filters << "company: #{params.dig(:search, :company)}" if params.dig(:search, :company).present?
      filters << "position: #{params.dig(:search, :position)}" if params.dig(:search, :position).present?
      filters << "experience: #{params.dig(:search, :experience_level)}" if params.dig(:search, :experience_level).present?
      filters << "work mode: #{params.dig(:search, :work_mode)}" if params.dig(:search, :work_mode).present?
      filters << "location: #{params.dig(:search, :location)}" if params.dig(:search, :location).present?

      filters
    end
    def filter_job_offers(job_offers, search_params)
      job_offers = job_offers.joins(recruiter: :company)

      if search_params[:company].present?
        job_offers = job_offers.where("companies.name ILIKE ?", "%#{search_params[:company]}%")
      end

      if search_params[:position].present?
        job_offers = job_offers.where("position ILIKE ?", "%#{search_params[:position]}%")
      end

      if search_params[:experience_level].present?
        job_offers = job_offers.where(experience_level: search_params[:experience_level])
      end

      if search_params[:work_mode].present?
        job_offers = job_offers.where(work_mode: search_params[:work_mode])
      end

      if search_params[:location].present?
        job_offers = job_offers.where("location ILIKE ?", "%#{search_params[:location]}%")
      end

      job_offers
    end
end
