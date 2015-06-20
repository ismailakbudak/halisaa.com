include Warden::Test::Helpers

def login_admin_feature
  before :each do
    @admin =  create(:admin)
    login_as @admin, scope: :admin
  end
end

def login_user_feature
  before :each do
    @user =  create(:user)
    login_as @user, scope: :user
  end
end