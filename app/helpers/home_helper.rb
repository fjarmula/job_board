module HomeHelper
  def active_filters
    filters = []

    filters << "company: #{params.dig(:search, :company)}" if params.dig(:search, :company).present?
    filters << "position: #{params.dig(:search, :position)}" if params.dig(:search, :position).present?
    filters << "experience: #{params.dig(:search, :experience_level)}" if params.dig(:search, :experience_level).present?
    filters << "work mode: #{params.dig(:search, :work_mode)}" if params.dig(:search, :work_mode).present?
    filters << "location: #{params.dig(:search, :location)}" if params.dig(:search, :location).present?

    filters
  end
end
