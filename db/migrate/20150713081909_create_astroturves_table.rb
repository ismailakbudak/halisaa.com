class CreateAstroturvesTable < ActiveRecord::Migration
  def change
    create_table :astroturves do |t|
      t.references :company, index: true
      t.string :name
      t.string :longitude
      t.string :latitude
      t.string :address
      t.string :phone
      t.references :city, index: true
      t.references :town, index: true
      t.decimal :week_price, precision: 7, scale: 2
      t.decimal :weekend_price, precision: 7, scale: 2
    end
  end
end
