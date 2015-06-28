class CreateCompanyProfilesTable < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gsm
      t.references :company, index: true

      t.timestamps
    end
  end
end
