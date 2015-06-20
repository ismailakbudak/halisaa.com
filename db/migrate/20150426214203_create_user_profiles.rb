class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :gsm
      t.references :user, index: true

      t.timestamps
    end
  end
end
