class AddRecruiterRefToJobOffers < ActiveRecord::Migration[8.1]
  def change
    add_reference :job_offers, :recruiter, null: false, foreign_key: true
  end
end
