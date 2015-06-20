require 'application_responder'

class User::ApplicationController < ActionController::Base
  layout 'application'
  before_action :authenticate_user!
  before_action :set_locale
  self.responder = ApplicationResponder
  respond_to :html, :json

  private
  def set_locale
    I18n.locale = current_user.locale
  end
end