class AddTitleFiledToCompanyProfilesTable < ActiveRecord::Migration
  def change
    add_column :company_profiles, :title, :string, :default => ''
  end
end
