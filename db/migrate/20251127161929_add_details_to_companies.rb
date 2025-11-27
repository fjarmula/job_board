class AddDetailsToCompanies < ActiveRecord::Migration[8.1]
  def change
    add_column :companies, :description, :text
    add_column :companies, :website, :string
    add_column :companies, :industry, :string
    add_column :companies, :size, :string
    add_column :companies, :founded_in, :integer
    add_column :companies, :headquarters, :string
  end
end
