class Company::CompanyController < Company::ApplicationController
  layout 'company/application'
  before_action :authenticate_company!
  add_breadcrumb I18n.t('activerecord.models.company'), :company_root_path

  def edit
  end

  def update
    @company = current_company
    @company.update(company_params)
    respond_with(@company, location: company_edit_path)
  end

  private

  def company_params
    params.require(:company).permit(:time_zone )
  end
end
