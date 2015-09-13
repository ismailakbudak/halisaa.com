require 'application_responder'

class Hq::ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :set_locale

  self.responder  = ApplicationResponder
  respond_to :html, :json

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale

      # Set audit current user
      Audited.current_user_method = :current_admin
    end
end