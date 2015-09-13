require 'application_responder'
class Api::ApplicationController < ActionController::Base

  before_action :set_locale

  # Added by İsmail
  include ApplicationHelper

  self.responder = ApplicationResponder
  respond_to :json

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale
      # Set audit current user
      Audited.current_user_method = :current_user
    end

end