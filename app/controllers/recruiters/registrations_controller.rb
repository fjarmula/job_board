class Recruiters::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_authentication

  def create
    build_resource(sign_up_params)

    company_name = params[:recruiter][:company]

    if company_name.present?
      company = Company.find_by(name: company_name)
      company_was_new = company.nil?

      if company_was_new
        company = Company.new(
          name: company_name,
          description: params[:company_description],
          website: params[:company_website],
          industry: params[:company_industry],
          size: params[:company_size],
          founded_in: params[:company_founded_in],
          headquarters: params[:company_headquarters]
        )

        unless company.save
          company.errors.full_messages.each do |message|
            resource.errors.add(:company, message)
          end
        end
      end
      resource.company = company if company&.persisted?
      resource.super_recruiter = company_was_new && company&.persisted?
    else
      resource.errors.add(:company, "can't be blank")
    end

    if resource.errors.empty? && resource.save
      if resource.active_for_authentication?
        if resource.super_recruiter?
          set_flash_message! :notice, "Welcome! You have signed up successfully as the super recruiter for #{company_name}."
        else
          set_flash_message! :notice, :signed_up
        end
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
