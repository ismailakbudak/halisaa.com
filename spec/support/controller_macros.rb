module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = create(:admin) # Using factory girl as an example
      admin.admin_profile = create(:admin_profile)
      sign_in admin
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      user.user_profile = create(:user_profile)
      sign_in user
    end
  end
end