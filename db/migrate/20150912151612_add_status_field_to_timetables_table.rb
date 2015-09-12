class AddStatusFieldToTimetablesTable < ActiveRecord::Migration
  def change
    add_column :timetables, :status, :integer, default: 0
  end
end
