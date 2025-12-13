class JobsFinder
  attr_reader :params

  def initialize(params = {})
    # Extract search params if they're nested
    @params = extract_search_params(params)
  end

  def call
    scope = initial_scope

    scope = filter_by_company(scope)
    scope = filter_by_position(scope)
    scope = filter_by_experience(scope)
    scope = filter_by_work_mode(scope)
    scope = filter_by_location(scope)

    sort_scope(scope)
  end

  private

    def extract_search_params(params)
      # Handle both nested and flat params
      search_params = params[:search] || params

      # Transform keys to symbols and handle enums
      search_params.deep_transform_keys { |key| key.to_sym }
    end

    def initial_scope
      JobOffer.all
    end

    def filter_by_company(scope)
      company = params.dig(:company)
      if company.present?
        scope.joins(recruiter: :company)
             .where("companies.name ILIKE ?", "%#{company}%")
      else
        scope
      end
    end

    def filter_by_position(scope)
      position = params.dig(:position)
      position.present? ? scope.where("position ILIKE ?", "%#{position}%") : scope
    end

    def filter_by_experience(scope)
      experience_level = params.dig(:experience_level)
      if experience_level.present?
        scope.where(experience_level: experience_level)
      else
        scope
      end
    end

    def filter_by_work_mode(scope)
      work_mode = params.dig(:work_mode)
      if work_mode.present?
        # Convert string to integer because enums are stored as integers
        mode = work_mode.to_i
        scope.where(work_mode: mode)
      else
        scope
      end
    end

    def filter_by_location(scope)
      location = params.dig(:location)
      location.present? ? scope.where("location ILIKE ?", "%#{location}%") : scope
    end

    def sort_scope(scope)
      scope.order(created_at: :desc)
    end
end
