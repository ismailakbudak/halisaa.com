class Astroturf < ActiveRecord::Base
  belongs_to :company
  belongs_to :city
  belongs_to :town
  has_many :timetables

  validates_presence_of :name, :longitude, :latitude, :address, :phone, :city_id, :town_id, :week_price, :weekend_price
  validates_numericality_of :week_price, greater_than: 0
  validates_numericality_of :weekend_price, greater_than: 0
  validate :city_id_exists
  validate :town_id_exists
  validate :city_has_this_town, :unless => :city_id_exists?

  private
  def city_id_exists?
    self.city_id.blank?
  end

  def city_id_exists
    valid = City.exists?(self.city_id)
    self.errors.add(:city_id, 'City must be defined') unless valid
  end
  def town_id_exists
    valid = Town.exists?(self.town_id)
    self.errors.add(:town_id, 'Town must be defined') unless valid
  end
  def city_has_this_town
    valid = City.find(self.city_id).towns.exists?(self.town_id)
    self.errors.add(:town_id, 'Town must be belongs to city') unless valid
  end
end
