class Recruiters::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_authentication

  def create
    build_resource(sign_up_params)

    company_name = params[:recruiter][:company]
    if company_name.present?
      resource.company = Company.find_or_create_by(name: company_name)
    else
      resource.errors.add(:company, "can't be blank")
    end

    if resource.errors.empty? && resource.save
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

    def sign_up_params
      params.require(:recruiter).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
