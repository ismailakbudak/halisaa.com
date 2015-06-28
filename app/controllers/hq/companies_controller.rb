class Hq::CompaniesController < Hq::ApplicationController
  before_action :set_company, only: [:block, :unblock]
  add_breadcrumb I18n.t('activerecord.models.companies'), :hq_companies_path

  def index
    @search = Company.ransack(params[:q])
    @companies = @search.result.includes(:company_profile).paginate(page: params[:page])
  end

  def block_all
    Company.update_all(blocked: true)
    flash[:success] = t('operation_success')
    redirect_to :back
  end

  def block
    @company.blocked = true
    if @company.save
      flash[:success] = t('companies.blocked_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  def unblock
    @company.blocked = false
    if @company.save
      flash[:success] = t('companies.activated_success')
    else
      flash[:danger] = t('operation_failed')
    end
    redirect_to :back
  end

  private
  def set_company
    @company = Company.find(params[:id])
  end

end
