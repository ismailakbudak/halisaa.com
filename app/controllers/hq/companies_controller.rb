class Hq::CompaniesController < Hq::ApplicationController
  before_action :set_company, only: [:block, :unblock, :sing_in]
  add_breadcrumb I18n.t('activerecord.models.companies'), :hq_companies_path

  def index
    @search = Company.ransack(params[:q])
    @companies = @search.result.includes(:company_profile).paginate(page: params[:page])
  end

  def new
    @company = Company.new
    @company.build_company_profile
  end

  def create
    @company = Company.new company_params
    @company.save
    respond_with @company, location: hq_companies_path
  end

  def block_all
    Company.update_all(blocked: true)
    flash[:success] = t('operation_success')
    redirect_to :back
  end

  def block
    @company.blocked = true
    if @company.save!(validate: false)
      flash[:success] = t('companies.blocked_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  def unblock
    @company.blocked = false
    if @company.save!(validate: false)
      flash[:success] = t('companies.activated_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  def sing_in
    sign_in(:company, @company)
    redirect_to company_root_url
  end

  private
    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:email, :password, :password_confirmation, company_profile_attributes: [:first_name, :gsm, :last_name, :title])
    end
end
