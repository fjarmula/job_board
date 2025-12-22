class AddSourceUrlToJobOffers < ActiveRecord::Migration[8.1]
  def change
    add_column :job_offers, :source_url, :string
    add_index :job_offers, :source_url, unique: true
  end
end
