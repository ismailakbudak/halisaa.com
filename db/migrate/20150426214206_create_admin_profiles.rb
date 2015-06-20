class CreateAdminProfiles < ActiveRecord::Migration
  def change
    create_table :admin_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gsm
      t.references :admin, index: true

      t.timestamps
    end
  end
end
