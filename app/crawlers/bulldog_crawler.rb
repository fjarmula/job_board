require "net/http"
require "uri"
require "nokogiri"
require "openssl"

class BulldogCrawler
  BASE_URL  = "https://bulldogjob.pl"
  START_URL = "https://bulldogjob.pl/companies/jobs/s/order,published,desc/" # taking advantage of the sorting by published date to be able to scrape the latest jobs first
  SCRAPED_PASSWORD = "password123"
  HEADERS = {
    "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 " \
      "(KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
  }.freeze

  def initialize(pages: 1, delay: 2)
    @pages = pages
    @delay = delay
  end

  def call
    (1..@pages).each do |page|
      url = "#{START_URL}page/#{page}"
      puts "Scraping: #{url}"
      doc = fetch_html(url)
      break unless doc

      job_items = doc.css("a[class*='JobListItem_item']")
      break if job_items.empty?

      job_items.each { |job| save_job(job) }
      sleep @delay
    end
  end

  private

    def fetch_html(url)
      uri = URI.parse(url)
      request = Net::HTTP::Get.new(uri)
      HEADERS.each { |k, v| request[k] = v }

      response = Net::HTTP.start(
        uri.host,
        uri.port,
        use_ssl: true,
        verify_mode: OpenSSL::SSL::VERIFY_NONE,
        read_timeout: 10
      ) { |http| http.request(request) }

      return Nokogiri::HTML(response.body) if response.is_a?(Net::HTTPSuccess)
      puts "Failed to fetch #{url} (#{response.code})"
      nil
    rescue => e
      puts "Error fetching #{url}: #{e.message}"
      nil
    end

    def save_job(anchor)
      position = anchor.at_css("h3")&.text&.strip || "Unknown"
      location = anchor.at_css("div[class*='details'] span.text-xs")&.text&.strip || "Unknown"
      employment_raw = anchor.css("div[class*='details'] div.hidden span")[0]&.text&.strip

      employment_type = case employment_raw
      when "Umowa o pracę" then "employment_contract"
      when "Umowa zlecenie" then "mandate_contract"
      when "B2B" then "b2b"
      else "other"
      end

      source_url = URI.join(BASE_URL, anchor["href"]).to_s
      company_name = anchor.at_css("div[class*='text-xxs']")&.text&.strip || "Undefined"
      company = Company.find_or_create_by!(name: company_name) do |c|
        c.headquarters = "undefined"
      end

      recruiter = company.recruiters.first_or_create! do |r|
        r.first_name = "Scraper"
        r.last_name  = "Bot"
        r.email      = "scraper+#{company.id}@example.com"
        r.password   = SCRAPED_PASSWORD
        r.super_recruiter = false
      end

      JobOffer.find_or_initialize_by(source_url: source_url).tap do |offer| # We use the job link as unique source URL to avoid duplicates
        offer.assign_attributes(
          position: position,
          location: location,
          employment_type: employment_type,
          work_dimension: "full_time",
          work_mode: "onsite",
          experience_level: "mid_level",
          recruiter: recruiter
        )
        offer.save!
      end
    rescue => e
      puts "Failed to save job: #{e.message}"
    end
end
