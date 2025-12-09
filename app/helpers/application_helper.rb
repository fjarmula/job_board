module ApplicationHelper
  # Creates a link that opens in a new tab for external URLs.
  def external_link_to(text, url)
    full_url = url.start_with?("http://", "https://") ? url : "http://#{url}"
    link_to text, full_url, target: "_blank"
  end
end
