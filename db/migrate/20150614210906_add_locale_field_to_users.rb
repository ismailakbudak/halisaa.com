class AddLocaleFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locale, :string, default: 'tr'
  end
end
