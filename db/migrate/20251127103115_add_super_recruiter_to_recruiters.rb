class AddSuperRecruiterToRecruiters < ActiveRecord::Migration[8.1]
  def change
    add_column :recruiters, :super_recruiter, :boolean, default: false
  end
end
