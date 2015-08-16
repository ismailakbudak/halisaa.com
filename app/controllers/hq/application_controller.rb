require 'application_responder'

class Hq::ApplicationController < ActionController::Base
  before_action :authenticate_admin!
  before_action :set_locale
  self.responder  = ApplicationResponder
  respond_to :html, :json

  private
    def set_locale
      I18n.locale = current_admin.locale
    end
end