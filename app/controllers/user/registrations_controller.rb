class User::RegistrationsController < Devise::RegistrationsController
  layout 'application'
  before_action :authenticate_user!
  before_action :redirect_user, only: [:destroy]

  def edit
  end

  private

  def redirect_user
      redirect_to root_path
  end

  def after_update_path_for(resource)
    root_path
  end

end
