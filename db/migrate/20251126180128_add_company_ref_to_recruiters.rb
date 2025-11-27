class AddCompanyRefToRecruiters < ActiveRecord::Migration[8.1]
  def change
    add_reference :recruiters, :company, null: false, foreign_key: true
  end
end
