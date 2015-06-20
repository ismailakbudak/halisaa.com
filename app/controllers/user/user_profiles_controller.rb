# encoding: UTF-8
class User::UserProfilesController < User::ApplicationController
  before_action :set_user_profile, only: [:show, :edit, :update, :destroy]
  add_breadcrumb I18n.t('activerecord.models.user_profiles'), :user_profile_path

  def show
    add_breadcrumb @user_profile.first_name, user_profile_path
    respond_with(@user_profile)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_user_profile_path
    @user_profile = current_user.build_user_profile
    respond_with(@user_profile)
  end

  def edit
    add_breadcrumb t('tooltips.edit'), edit_user_profile_path
  end

  def create
    @user_profile = current_user.build_user_profile(user_profile_params)
    @user_profile.save
    respond_with(@user_profile, location: user_profile_path)
  end

  def update
    @user_profile.update(user_profile_params)
    respond_with(@user_profile, location: user_profile_path)
  end

  private

  def set_user_profile
    if current_user.user_profile.nil?
      flash[:info] = t('users.first_create_profile')
      redirect_to new_user_profile_path
    end
    @user_profile = current_user.user_profile
  end

  def user_profile_params
    params.require(:user_profile).permit(:first_name, :gsm, :last_name)
  end
end
