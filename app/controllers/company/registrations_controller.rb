class Company::RegistrationsController < Devise::RegistrationsController
  layout 'application'
  before_action :authenticate_company!
  before_action :redirect_company, only: [:destroy]
  add_breadcrumb I18n.t('dock.dashboard'), :company_root_path
  layout :layout_by_resource

  private
    def layout_by_resource
      if company_signed_in?
        'company/application'
      else
        'application'
      end
    end

    def redirect_company
        redirect_to company_root_path
    end

    def after_update_path_for(resource)
      company_root_path
    end

end
