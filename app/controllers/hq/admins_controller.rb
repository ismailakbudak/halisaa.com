class Hq::AdminsController < Hq::ApplicationController

  before_action :set, only: [:block, :unblock]
  add_breadcrumb I18n.t('activerecord.models.admins'), :hq_admins_path

  def index
    @search = Admin.ransack(params[:q])
    @admins = @search.result.includes(:admin_profile).paginate(page: params[:page])
  end

  def block_all
    Admin.update_all(blocked: true)
    flash[:success] = t('operation_success')
    redirect_to :back
  end

  def block
    @admin.blocked = true
    if @admin.save
      flash[:success] = t('admins.blocked_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  def unblock
    @admin.blocked = false
    if @admin.save
      flash[:success] = t('admins.activated_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  private
    def set
      @admin = Admin.find(params[:id])
    end

end
