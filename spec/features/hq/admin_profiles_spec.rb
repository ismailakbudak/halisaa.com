require 'spec_helper'

describe 'AdminProfile' do

  login_admin_feature

  describe "Create admin profile" do

    before(:each) do
      visit hq_dashboard_index_url
      page.should have_content 'Hi'
    end

    it "create admin profile" do
      expect{
        first(:link, 'Edit Profile').click
        fill_in 'First name', with: 'John'
        fill_in 'Last name', with: 'Smith'
        fill_in 'Gsm', with: '0555 555 55 55'
        click_button 'Create Admin profile'
      }.to change(AdminProfile,:count).by(1)
      page.should have_content "Admin profile was successfully created."
      page.should have_content 'John'
      page.should have_content 'Smith'
    end

    it "should not create admin profile without first name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: ''
        fill_in 'Last name', with: 'Smith'
        fill_in 'Gsm', with: '0555 555 55 55'
        click_button 'Create Admin profile'
      }.to change(AdminProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end

    it "should not create admin profile without last name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: 'John'
        fill_in 'Last name', with: ''
        fill_in 'Gsm', with: '0555 555 55 55'
        click_button 'Create Admin profile'
      }.to change(AdminProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end
  end

  describe "Update admin profile" do

    before(:each) do
      @admin.admin_profile = create(:new_admin_profile)
      @admin.save
      visit hq_dashboard_index_url
      page.should have_content 'Hi'
    end

    it "update admin profile" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: 'Ismail'
        fill_in 'Last name', with: 'Akbudak'
        fill_in 'Gsm', with: '0555 555 55 56'
        find('.form-actions input').click
      }.to change(AdminProfile,:count).by(0)
      page.should have_content "Admin profile was successfully updated."
      page.should have_content 'Ismail'
      page.should have_content 'Akbudak'
      page.should have_content '0555 555 55 56'
    end

    it "should not update admin profile without first name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: ''
        find('.form-actions input').click
      }.to change(AdminProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end

    it "should not update admin profile without last name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'Last name', with: ''
        find('.form-actions input').click
      }.to change(AdminProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end

  end
end