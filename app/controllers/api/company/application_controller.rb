require 'application_responder'

class Api::Company::ApplicationController < ActionController::Base
  layout 'company/application'
  before_action :authenticate_company!
  before_filter :set_time_zone
  before_action :set_locale
  self.responder = ApplicationResponder
  respond_to :json

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale
      # Set audit current user
      Audited.current_user_method = :current_company
    end

  protected
    def set_time_zone
      Time.zone = current_company.time_zone if company_signed_in? && current_company.time_zone.present?
    end

end