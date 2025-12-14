class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Authentication
  include Pundit::Authorization

  skip_before_action :require_authentication, if: :devise_controller?

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protected

    def pundit_user
      current_recruiter || current_user_from_authentication
    end
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :company ])
    end
  private
      def current_user_from_authentication
        Current.session&.user
      end
end
