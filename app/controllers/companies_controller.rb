class CompaniesController < ApplicationController
  allow_unauthenticated_access only: [ :show, :edit, :update ]
  before_action :set_company, only: [ :show, :edit, :update ]
  before_action :authorize_super_recruiter!, only: [ :edit, :update ]

  def show
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to @company, notice: "Company profile was successfully updated."
    else
      render :edit
    end
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def authorize_super_recruiter!
      unless current_recruiter&.super_recruiter? && current_recruiter.company == @company
        redirect_to @company, alert: "Only the super recruiter can edit company profile."
      end
    end

    def company_params
      params.require(:company).permit(:name, :description, :website, :industry, :size, :founded_in, :headquarters)
    end
end
