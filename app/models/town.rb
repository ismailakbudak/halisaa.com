class Town < ActiveRecord::Base
  audited
  belongs_to :city
  has_many :astroturves, dependent: :restrict_with_error
end
