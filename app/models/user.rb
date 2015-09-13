class User < ActiveRecord::Base
  audited
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
        has_one :user_profile, dependent: :restrict_with_error
        accepts_nested_attributes_for :user_profile
end
