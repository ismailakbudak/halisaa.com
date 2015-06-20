class AddLocaleFieldToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :locale, :string, default: 'tr'
  end
end
