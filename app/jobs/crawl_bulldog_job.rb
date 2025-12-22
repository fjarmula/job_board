class CrawlBulldogJob < ApplicationJob
  queue_as :default

  def perform(*args)
    BulldogCrawler.new.(pages: 5).call
  end
end
