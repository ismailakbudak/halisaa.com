class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.references :astroturf, index: true
      t.datetime :start
      t.datetime :finish
      t.string :desc
      t.string :source
      t.integer :source_id
      t.timestamps
    end
  end
end
