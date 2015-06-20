class Hq::LanguageController < Hq::ApplicationController

  def change
    if params[:locale].in?(['en', 'tr'])
      I18n.locale = params[:locale]
      current_admin.locale = params[:locale]
      current_admin.save
    end
    redirect_to :back
  end

end
