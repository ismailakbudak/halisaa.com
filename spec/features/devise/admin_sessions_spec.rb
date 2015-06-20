require 'spec_helper'

describe 'Admin Sessions' do

  describe "login" do
    before :each do
      @admin =  create(:admin)
    end

    it "login to system" do
      visit new_admin_session_url
      expect {
        fill_in 'Email', with: 'admin@test.com'
        fill_in 'Password', with: '12341234'
        click_button 'Sign in'
      }.to change(Admin,:count).by(0)
      page.should have_content "Signed in successfully."
    end
  end

  describe "logout" do
    login_admin_feature
    it "logout to system" do
      visit hq_dashboard_index_url
      expect {
        first(:link, 'Sign out').click
      }.to change(Admin,:count).by(0)
      page.should have_content "Signed out successfully."
    end
  end

end