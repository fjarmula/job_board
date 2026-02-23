class BulldogSyncJob < ApplicationJob
  queue_as :default

  def perform(pages = 1)
    BulldogSyncService.new(pages: pages).execute
  end
end
