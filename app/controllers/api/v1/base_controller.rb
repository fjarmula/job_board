module Api
  module V1
    class BaseController < ApplicationController
      # Add any API-specific logic here
      # For example, you might want different authentication for APIs
      # skip_before_action :verify_authenticity_token
    end
  end
end
