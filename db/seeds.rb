# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



#Admin.create(:email => 'app@app.com', :password => '12341234')

for i in 0..5
  @user = User.create(:email => "#{i}-app@app.com", :password => '12341234')
  @user.user_profile = UserProfile.create('first_name' => "#{i} first name",'last_name' => "#{i} last name",)
end