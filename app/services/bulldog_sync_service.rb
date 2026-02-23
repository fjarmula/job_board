class BulldogSyncService
  def initialize(pages: 1, delay: 2)
    @pages = pages
    @delay = delay
    @crawler = BulldogCrawler.new
  end

  def execute
    (1..@pages).each do |page|
      jobs = @crawler.scrape_page(page)
      break if jobs.empty?

      jobs.each do |job_hash|
        JobOfferImporter.import(job_hash)
      end
      sleep(@delay)
    end
  end
end
