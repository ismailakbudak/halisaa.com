class Company::CompanyProfilesController < Company::ApplicationController
  layout 'company/application'
  before_action :check_company_profile, only: [:new, :create]
  before_action :set_company_profile, only: [:show, :edit, :update]
  add_breadcrumb I18n.t('activerecord.models.company_profile'), :company_profile_path

  def show
    add_breadcrumb @company_profile.first_name, company_profile_path
    respond_with(@company_profile)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_company_profile_path
    @company_profile = current_company.build_company_profile
    respond_with(@company_profile)
  end

  def edit
    add_breadcrumb t('tooltips.edit'), edit_company_profile_path
  end

  def create
    @company_profile = current_company.build_company_profile(company_profile_params)
    @company_profile.save
    respond_with(@company_profile, location: company_profile_path)
  end

  def update
    @company_profile.update(company_profile_params)
    respond_with(@company_profile, location: company_profile_path)
  end

  private

  def check_company_profile
    if current_comapany.comapany_profile.present?
      redirect_to comapany_profile_path
    end
  end

  def set_company_profile
    if current_company.company_profile.nil?
      flash[:info] = t('companies.first_create_profile')
      redirect_to new_company_profile_path
    end
    @company_profile = current_company.company_profile
  end

  def company_profile_params
    params.require(:company_profile).permit(:first_name, :gsm, :last_name, :title)
  end
end
