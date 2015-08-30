class AddTimestamspToAstroturvesTable < ActiveRecord::Migration
  def change
    add_timestamps(:astroturves)
  end
end
