class Company::LanguageController < Company::ApplicationController

  def change
    if params[:locale].in?(['en', 'tr'])
      I18n.locale = params[:locale]
      current_company.locale = params[:locale]
      current_company.save
    end
    redirect_to request.referer || company_root_path
  end

end
