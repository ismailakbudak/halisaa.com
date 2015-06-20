class LanguageController < ApplicationController

  def change
    if params[:locale].in?(['en', 'tr'])
      I18n.locale = params[:locale]
      if !current_user.nil?
        current_user.locale = params[:locale]
        current_user.save
      end
    end
    redirect_to :back
  end

end
