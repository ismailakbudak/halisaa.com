class City < ActiveRecord::Base
  audited

  has_many :towns, dependent: :restrict_with_error
  has_many :astroturves, dependent: :restrict_with_error
end
