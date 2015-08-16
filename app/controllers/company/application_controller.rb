require 'application_responder'

class Company::ApplicationController < ActionController::Base
  layout 'company/application'
  before_action :authenticate_company!
  before_action :set_locale
  self.responder = ApplicationResponder
  respond_to :html, :json

  private
    def set_locale
      I18n.locale =  current_company.locale
    end
end