require 'spec_helper'

describe User::UserProfilesController do

  login_user

  before :each do
    @user = subject.current_user
    @user_profile = subject.current_user.user_profile
    @show_path = user_profile_path
  end

  it "should have a current_user" do
    @user.should_not be_nil
  end

  # describe "GET #index" do
  #   it "populates an array of user_profiles" do
  #     contact = (:user_profile)
  #     get :index
  #     assigns(:user_profiles).should eq([user_profile])
  #   end
  #
  #   it "renders the :index view" do
  #     get :index
  #     response.should render_template :index
  #   end
  # end

  describe "GET #show" do
    it "assigns the requested user_profile to @user_profile" do
      get :show, id: @user_profile
      assigns(:user_profile).should eql @user_profile
    end

    it "renders the :show template" do
      get :show, id:  @user_profile
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new user_profile to @user_profile"  do
      get :new
      assigns(:user_profile).should eql @user.user_profile
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new user_profile in the database"  do
        expect{
          post :create, user_profile: attributes_for(:user_profile)
        }.to change(UserProfile,:count).by(1)
      end
      it "redirects to the user_profile" do
        post :create, user_profile: attributes_for(:user_profile)
        response.should redirect_to @show_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new user_profile in the database"  do
        expect{
          post :create, user_profile: attributes_for(:invalid_user_profile)
        }.to_not change(UserProfile,:count)
      end
      it "re-renders the :new template" do
        post :create, user_profile: attributes_for(:invalid_user_profile)
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    it "assigns a user_profile to @user_profile" do
      get :edit, id: @user_profile
      assigns(:user_profile).should eql @user_profile
    end

    it "renders the :edit template" do
      get :edit, id:  @user_profile
      response.should render_template :edit
    end
  end

  describe 'PUT update' do
    before :each do
      @user.user_profile = create(:user_profile, first_name: "Lawrence", last_name: "Smith")
      @profile = @user.user_profile
    end

    context "valid attributes" do
      it "located the requested @profile" do
        put :update, id: @profile, user_profile: attributes_for(:user_profile)
        assigns(:user_profile).should eql @user.user_profile
      end

      it "changes @profile's attributes" do
        put :update, id: @profile,
            user_profile: attributes_for(:user_profile, first_name: "Larry", last_name: "Smith")
        @profile.reload
        @profile.first_name.should eql "Larry"
        @profile.last_name.should eql "Smith"
      end

      it "redirects to the updated @profile" do
        put :update, id: @profile, user_profile: attributes_for(:user_profile)
        response.should redirect_to @show_path
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile" do
        put :update, id: @profile, user_profile: attributes_for(:invalid_user_profile)
        assigns(:user_profile).should eql @profile
      end

      it "does not change @profile's attributes" do
        put :update, id: @profile,
            user_profile: attributes_for(:user_profile, first_name: "Larry", last_name: nil)
        @profile.reload
        @profile.first_name.should_not eql "Larry"
        @profile.last_name.should eql "Smith"
      end

      it "re-renders the edit method" do
        put :update, id: @profile, user_profile: attributes_for(:invalid_user_profile)
        response.should render_template :edit
      end
    end
  end

  # describe 'DELETE destroy' do
  #   before :each do
  #     @user_profile= Factory(:user_profile)
  #   end
  #
  #   it "deletes the user_profile" do
  #     expect{
  #       delete :destroy, id: @user_profile
  #     }.to change(AdminProfile,:count).by(-1)
  #   end
  #
  #   it "redirects to user_profiles#index" do
  #     delete :destroy, id: @user_profile
  #     response.should redirect_to hq_user_profile_url
  #   end
  # end

end
