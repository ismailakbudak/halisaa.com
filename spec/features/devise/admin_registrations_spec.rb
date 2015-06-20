require 'spec_helper'

describe "Admin Registration" do

  login_admin_feature

  before(:each) do
    visit hq_dashboard_index_url
  end

  it "should update login info" do
    expect{
      click_link  'Edit Login Info'
      fill_in 'Email', with: 'isoakbudak@gmail.com'
      fill_in 'admin[password]', with: '12341234'
      fill_in 'admin[password_confirmation]', with: '12341234'
      fill_in 'admin[current_password]', with: '12341234'
      find('.form-actions input').click
    }.to change(Admin,:count).by(0)
    page.should have_content 'You updated your account successfully.'
    page.should have_content 'Hi isoakbudak@gmail.com'
  end

  it "should not update login info with wrong current password" do
    expect{
      click_link  'Edit Login Info'
      fill_in 'Email', with: 'isoakbudak@gmail.com'
      fill_in 'admin[current_password]', with: '123412345'
      find('.form-actions input').click
    }.to change(Admin,:count).by(0)
    page.should have_content 'Please review the problems below'
    within('form') do
      page.should have_content 'is invalid'
    end
  end

  it "should not update login info without password confirmation" do
    expect{
      click_link  'Edit Login Info'
      fill_in 'Email', with: 'isoakbudak@gmail.com'
      fill_in 'admin[password]', with: '12341234'
      fill_in 'admin[current_password]', with: '12341234'
      find('.form-actions input').click
    }.to change(Admin,:count).by(0)
    page.should have_content 'Please review the problems below'
    within('form') do
      page.should have_content 'doesn\'t match Password'
    end
  end

  it "should not update with same email adress" do
    create(:admin, email: "test@test.com")
    expect{
      click_link 'Edit Login Info'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'admin[current_password]', with: '12341234'
      find('.form-actions input').click
    }.to change(Admin,:count).by(0)
    page.should have_content 'Please review the problems below'
    within('form') do
      page.should have_content 'has already been taken'
    end
  end

end