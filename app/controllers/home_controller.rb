class HomeController < ApplicationController
  allow_unauthenticated_access
  helper_method :search_params_present?

  def index
    @job_offers = JobsFinder.new(params).call
  end

  private
    def search_params_present?(search_params)
      search_params.values.any?(&:present?)
    end
end
