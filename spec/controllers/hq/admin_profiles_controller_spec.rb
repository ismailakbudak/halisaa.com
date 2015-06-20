require 'spec_helper'

describe Hq::AdminProfilesController do

  login_admin

  before :each do
    @admin = subject.current_admin
    @admin_profile = subject.current_admin.admin_profile
    @show_path = hq_admin_profile_path
  end

  it "should have a current_admin" do
    @admin.should_not be_nil
  end

  # describe "GET #index" do
  #   it "populates an array of admin_profiles" do
  #     contact = (:admin_profile)
  #     get :index
  #     assigns(:admin_profiles).should eq([admin_profile])
  #   end
  #
  #   it "renders the :index view" do
  #     get :index
  #     response.should render_template :index
  #   end
  # end

  describe "GET #show" do
    it "assigns the requested admin_profile to @admin_profile" do
      get :show, id: @admin_profile
      assigns(:admin_profile).should eql @admin_profile
    end

    it "renders the :show template" do
      get :show, id:  @admin_profile
      response.should render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new admin_profile to @admin_profile"  do
      get :new
      assigns(:admin_profile).should eql @admin.admin_profile
    end

    it "renders the :new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new admin_profile in the database"  do
        expect{
          post :create, admin_profile: attributes_for(:admin_profile)
        }.to change(AdminProfile,:count).by(1)
      end
      it "redirects to the admin_profile contact" do
        post :create, admin_profile: attributes_for(:admin_profile)
        response.should redirect_to @show_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new admin_profile in the database"  do
        expect{
          post :create, admin_profile: attributes_for(:invalid_admin_profile)
        }.to_not change(AdminProfile,:count)
      end
      it "re-renders the :new template" do
        post :create, admin_profile: attributes_for(:invalid_admin_profile)
        response.should render_template :new
      end
    end
  end

  describe "GET #edit" do
    it "assigns a admin ti to @admin_profile" do
      get :edit, id: @admin_profile
      assigns(:admin_profile).should eql @admin_profile
    end

    it "renders the :edit template" do
      get :edit, id:  @admin_profile
      response.should render_template :edit
    end
  end

  describe 'PUT update' do
    before :each do
      @admin.admin_profile = create(:admin_profile, first_name: "Lawrence", last_name: "Smith")
      @profile = @admin.admin_profile
    end

    context "valid attributes" do
      it "located the requested @profile" do
        put :update, id: @profile, admin_profile: attributes_for(:admin_profile)
        assigns(:admin_profile).should eql @admin.admin_profile
      end

      it "changes @profile's attributes" do
        put :update, id: @profile,
            admin_profile: attributes_for(:admin_profile, first_name: "Larry", last_name: "Smith")
        @profile.reload
        @profile.first_name.should eql "Larry"
        @profile.last_name.should eql "Smith"
      end

      it "redirects to the updated @profile" do
        put :update, id: @profile, admin_profile: attributes_for(:admin_profile)
        response.should redirect_to @show_path
      end
    end

    context "invalid attributes" do
      it "locates the requested @profile" do
        put :update, id: @profile, admin_profile: attributes_for(:invalid_admin_profile)
        assigns(:admin_profile).should eql @profile
      end

      it "does not change @profile's attributes" do
        put :update, id: @profile,
            admin_profile: attributes_for(:admin_profile, first_name: "Larry", last_name: nil)
        @profile.reload
        @profile.first_name.should_not eql "Larry"
        @profile.last_name.should eql "Smith"
      end

      it "re-renders the edit method" do
        put :update, id: @profile, admin_profile: attributes_for(:invalid_admin_profile)
        response.should render_template :edit
      end
    end
  end

  # describe 'DELETE destroy' do
  #   before :each do
  #     @admin_profile= Factory(:admin_profile)
  #   end
  #
  #   it "deletes the admin_profile" do
  #     expect{
  #       delete :destroy, id: @admin_profile
  #     }.to change(AdminProfile,:count).by(-1)
  #   end
  #
  #   it "redirects to admin_profiles#index" do
  #     delete :destroy, id: @admin_profile
  #     response.should redirect_to hq_admin_profile_url
  #   end
  # end

end
