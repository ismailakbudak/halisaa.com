class Hq::UsersController < Hq::ApplicationController

  before_action :set_user, only: [:block, :unblock]
  add_breadcrumb I18n.t('activerecord.models.users'), :hq_users_path

  def index
    @search = User.ransack(params[:q])
    @users = @search.result.paginate(page: params[:page])
  end

  def block_all
    User.update_all(blocked: true)
    flash[:success] = t('operation_success')
    redirect_to :back
  end

  def block
    @user.blocked = true
    if @user.save
      flash[:success] = t('users.blocked_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  def unblock
    @user.blocked = false
    if @user.save
      flash[:success] = t('users.activated_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

end
