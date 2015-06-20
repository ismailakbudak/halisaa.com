require 'spec_helper'


describe 'User Sessions' do

  describe "login" do
    before :each do
      @user =  create(:user)
    end

    it "login to system" do
      visit root_url
      expect {
        first(:link, 'Sign in').click
        fill_in 'Email', with: 'factory@test.com'
        fill_in 'Password', with: '12341234'
        click_button 'Sign in'
      }.to change(User,:count).by(0)
      page.should have_content "Signed in successfully."
    end
  end

  describe "logout" do
    login_user_feature
    it "logout to system" do
      visit root_url
      expect {
        first(:link, 'Sign out').click
      }.to change(User,:count).by(0)
      page.should have_content "Signed out successfully."
    end
  end

end
