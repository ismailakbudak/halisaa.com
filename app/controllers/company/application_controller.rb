require 'application_responder'

class Company::ApplicationController < ActionController::Base
  layout 'company/application'
  before_action :authenticate_company!
  before_action :set_locale
  self.responder = ApplicationResponder
  respond_to :html, :json

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale
    end
end