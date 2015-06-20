require 'spec_helper'

describe 'User Registration' do
    it "it create new user" do
        visit root_url
        expect{
          click_link  'Sign up'
          fill_in 'Name', with: 'John'
          fill_in 'Email', with: 'isoakbudak@gmail.com'
          fill_in 'user[password]', with: '12341234'
          fill_in 'user[password_confirmation]', with: '12341234'
          click_button "Sign up"
        }.to change(User,:count).by(1)
        page.should have_content "You have signed up successfully."
        within 'h1' do
          page.should have_content 'Welcome to halisaa'
        end
        page.should have_content 'Name: John'
    end

    describe "update user login info" do

      login_user_feature

      before(:each) do
        visit root_url
      end

      it "should update login info" do
        expect{
          click_link  'Edit Login Info'
          fill_in 'Email', with: 'isoakbudak@gmail.com'
          fill_in 'user[password]', with: '12341234'
          fill_in 'user[password_confirmation]', with: '12341234'
          fill_in 'user[current_password]', with: '12341234'
          find('.form-actions input').click
        }.to change(User,:count).by(0)
        page.should have_content 'You updated your account successfully.'
        page.should have_content 'isoakbudak@gmail.com'
      end

      it "should not update login info with wrong current password" do
        expect{
          click_link  'Edit Login Info'
          fill_in 'Email', with: 'isoakbudak@gmail.com'
          fill_in 'user[current_password]', with: '123412345'
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
          fill_in 'user[password]', with: '12341234'
          fill_in 'user[current_password]', with: '12341234'
          find('.form-actions input').click
        }.to change(Admin,:count).by(0)
        page.should have_content 'Please review the problems below'
        within('form') do
          page.should have_content 'doesn\'t match Password'
        end
      end

      it "should not update with same email adress" do
        create(:user, email: "test@test.com")
        expect{
          click_link 'Edit Login Info'
          fill_in 'Email', with: 'test@test.com'
          fill_in 'user[current_password]', with: '12341234'
          find('.form-actions input').click
        }.to change(Admin,:count).by(0)
        page.should have_content 'Please review the problems below'
        within('form') do
          page.should have_content 'has already been taken'
        end
      end

    end
end
