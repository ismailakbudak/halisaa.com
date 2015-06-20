class AdminProfile < ActiveRecord::Base
  belongs_to :admin
  validates_presence_of :first_name, :last_name

  def full_name
    [first_name, last_name].join(' ')
  end

  def self.by_letter(letter)
    where("last_name LIKE ?", "#{letter}%").order(:last_name)
  end

end
