require 'spec_helper'

describe 'UserProfile' do

  login_user_feature

  describe "Create user profile" do

    before(:each) do
      visit root_url
      page.should have_content 'Welcome to halisaa'
    end

    it "create user profile" do
      expect{
        first(:link, 'Edit Profile').click
        fill_in 'First name', with: 'John'
        fill_in 'Last name', with: 'Smith'
        fill_in 'Gsm', with: '0555 555 55 55'
        click_button 'Create User profile'
      }.to change(UserProfile,:count).by(1)
      page.should have_content "User profile was successfully created."
      page.should have_content 'John'
      page.should have_content 'Smith'
    end

    it "should not create User profile without first name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: ''
        fill_in 'Last name', with: 'Smith'
        fill_in 'Gsm', with: '0555 555 55 55'
        click_button 'Create User profile'
      }.to change(UserProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end

    it "should not create User profile without last name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: 'John'
        fill_in 'Last name', with: ''
        fill_in 'Gsm', with: '0555 555 55 55'
        click_button 'Create User profile'
      }.to change(UserProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end
  end

  describe "Update User profile" do

    before(:each) do
      @user.user_profile = create(:new_user_profile)
      @user.save
      visit root_url
      page.should have_content 'Welcome to halisaa'
    end

    it "update User profile" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: 'Ismail'
        fill_in 'Last name', with: 'Akbudak'
        fill_in 'Gsm', with: '0555 555 55 56'
        find('.form-actions input').click
      }.to change(UserProfile,:count).by(0)
      page.should have_content "User profile was successfully updated."
      page.should have_content 'Ismail'
      page.should have_content 'Akbudak'
      page.should have_content '0555 555 55 56'
    end

    it "should not update User profile without first name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'First name', with: ''
        find('.form-actions input').click
      }.to change(UserProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end

    it "should not update User profile without last name" do
      expect{
        first(:link, 'Edit').click
        fill_in 'Last name', with: ''
        find('.form-actions input').click
      }.to change(UserProfile,:count).by(0)
      page.should have_content 'Please review the problems below'
      within('form') do
        page.should have_content 'can\'t be blank'
      end
    end

  end
end