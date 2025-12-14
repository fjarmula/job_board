class CompaniesController < ApplicationController
  allow_unauthenticated_access only: [ :show, :edit, :update ]
  before_action :set_company, only: [ :show, :edit, :update ]

  def show
    authorize @company, :show?
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
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

    def company_params
      params.require(:company).permit(:name, :description, :website, :industry, :size, :founded_in, :headquarters)
    end
end
