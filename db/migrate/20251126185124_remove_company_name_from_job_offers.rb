class RemoveCompanyNameFromJobOffers < ActiveRecord::Migration[8.1]
  def change
    remove_column :job_offers, :company_name, :string
  end
end
