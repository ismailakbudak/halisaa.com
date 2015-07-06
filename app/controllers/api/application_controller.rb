require 'application_responder'
class Api::ApplicationController < ActionController::Base

  # Added by İsmail
  include ApplicationHelper

  self.responder = ApplicationResponder
  respond_to :json
end