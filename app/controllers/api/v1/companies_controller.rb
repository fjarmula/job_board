class Api::V1::CompaniesController < ApplicationController
  allow_unauthenticated_access only: [ :check_exists ]
  def check_exists
    company_name = params[:name]&.strip

    if company_name.present?
      company_exists = Company.exists?(name: company_name)
      render json: { exists: company_exists }
    else
      render json: { exists: false }
    end
  end
end
