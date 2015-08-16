class Hq::LanguageController < Hq::ApplicationController

  def change
    fail 'aa'
    if params[:locale].in?(['en', 'tr'])
      I18n.locale = params[:locale]
      current_admin.locale = params[:locale]
      current_admin.save
    end
    redirect_to request.referer || hq_root_path
  end

end
