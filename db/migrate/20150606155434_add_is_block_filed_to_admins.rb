class AddIsBlockFiledToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :blocked, :boolean, default: false
  end
end
