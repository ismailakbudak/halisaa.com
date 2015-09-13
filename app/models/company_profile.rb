class CompanyProfile < ActiveRecord::Base
  audited

  belongs_to :company

  validates_presence_of :first_name, :last_name, :title

  def full_name
    [first_name, last_name].join(' ')
  end

  def self.by_letter(letter)
    where("last_name LIKE ?", "#{letter}%").order(:last_name)
  end

end
