class CreateJobOffers < ActiveRecord::Migration[8.1]
  def change
    create_table :job_offers do |t|
      t.string :company_name
      t.string :position
      t.string :location
      t.integer :work_mode
      t.integer :employment_type
      t.integer :experience_level
      t.integer :work_dimension
      t.decimal :salary_min
      t.decimal :salary_max
      t.text :description
      t.text :tech_stack

      t.timestamps
    end
  end
end
