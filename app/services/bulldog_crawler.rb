require "net/http"
require "uri"
require "nokogiri"
require "openssl"
class BulldogCrawler
  BASE_URL = "https://bulldogjob.pl"
  HEADERS = { "User-Agent" => "Mozilla/5.0..." }.freeze

  def scrape_page(page_number)
    url = "#{BASE_URL}/companies/jobs/s/order,published,desc/page/#{page_number}"
    doc = fetch_html(url)
    return [] unless doc

    doc.css("a[class*='JobListItem_item']").map { |item| parse_job_data(item) }
  end

  private

    def fetch_html(url)
      uri = URI.parse(url)
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        http.get(uri.path, HEADERS)
      end
      Nokogiri::HTML(response.body) if response.is_a?(Net::HTTPSuccess)
    end

    def parse_job_data(anchor)
      {
        position: anchor.at_css("h3")&.text&.strip,
        location: anchor.at_css("div[class*='details'] span.text-xs")&.text&.strip,
        source_url: URI.join(BASE_URL, anchor["href"]).to_s,
        company_name: anchor.at_css("div[class*='text-xxs']")&.text&.strip,
        employment_type: map_employment(anchor.css("div[class*='details'] div.hidden span")[0]&.text&.strip)
      }
    end

    def map_employment(raw)
      case raw
      when "Umowa o pracę" then "employment_contract"
      when "Umowa zlecenie" then "mandate_contract"
      when "B2B" then "b2b"
      else "other"
      end
    end
end
