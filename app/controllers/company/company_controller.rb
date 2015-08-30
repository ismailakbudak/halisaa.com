class Company::CompanyController < Company::ApplicationController
  layout 'company/application'
  before_action :authenticate_company!

  def edit
  end

  def update
    current_company.update(company_params)
    respond_with(current_company, location: company_edit_path)
  end

  private

  def company_params
    params.require(:company).permit(:time_zone )
  end
end
