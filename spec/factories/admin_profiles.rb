FactoryGirl.define do
  factory :admin_profile do
    first_name 'First Name'
    last_name 'Last Name'
    gsm '05065051020'
  end

  factory :invalid_admin_profile, parent: :admin_profile do |f|
    f.first_name nil
  end

  factory :new_admin_profile, parent: :admin_profile do |f|
    f.first_name 'John'
    f.last_name 'Smith'
    f.gsm '0555 555 55 55'
  end


end
