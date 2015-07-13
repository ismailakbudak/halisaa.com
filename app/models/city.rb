class City < ActiveRecord::Base
  has_many :towns
  has_many :astroturves
end
