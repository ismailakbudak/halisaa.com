class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :company_profile
  accepts_nested_attributes_for :company_profile
  has_many :astroturves

  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name).keys

end
