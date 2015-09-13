class Timetable < ActiveRecord::Base
  audited
  belongs_to :astroturf

  # Enums
  enum status: [ :empty, :available, :booked, :not_available ]

  #Scopes
  scope :empty, -> { where(status: Timetable.statuses[:empty]) }
  scope :available, -> { where(status: Timetable.statuses[:available]) }
  scope :not_empty, -> { where.not(status: Timetable.statuses[:empty]) }
  scope :not_booked, -> { where.not(status: Timetable.statuses[:booked]) }
  scope :after_number_month_ago, ->(number) { where('finish >= ?', number.month.ago) }
end
