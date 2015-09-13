class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  audited
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        has_one :admin_profile, dependent: :restrict_with_error
        accepts_nested_attributes_for :admin_profile

end
