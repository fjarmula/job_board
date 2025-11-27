class RecruitersController < ApplicationController
  allow_unauthenticated_access only: [ :show ]
  def show
    @recruiter = Recruiter.find(params[:id])
  end
end
