class AddWorkHoursFieldsToAstroturvesTable < ActiveRecord::Migration
  def change
    add_column :astroturves, :start_time, :time, default: '09:00'
    add_column :astroturves, :finish_time, :time, default: '02:00'
  end
end
