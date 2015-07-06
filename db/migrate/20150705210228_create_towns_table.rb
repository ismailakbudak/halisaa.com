class CreateTownsTable < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.references :city
      t.string :name
      t.timestamps
    end
  end
end
