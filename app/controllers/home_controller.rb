class HomeController < ApplicationController
  allow_unauthenticated_access
  helper_method :search_params_present?, :active_filters

  def index
    @job_offers = JobOffer.all
    @job_offers = @job_offers.search_and_filter(params[:search]) if params[:search].present?
    @job_offers = @job_offers.order(created_at: :desc)
  end


  private
    def search_params_present?(search_params)
      search_params.values.any?(&:present?)
    end
end
