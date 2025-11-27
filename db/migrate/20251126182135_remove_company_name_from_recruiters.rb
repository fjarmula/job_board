class RemoveCompanyNameFromRecruiters < ActiveRecord::Migration[8.1]
  def change
    remove_column :recruiters, :company_name, :string
  end
end
