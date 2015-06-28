class Company::DashboardController < Company::ApplicationController
  layout 'company/application'
  add_breadcrumb I18n.t('dock.dashboard'), :company_root_path

  def index
  end

end