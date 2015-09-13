class ApplicationController < ActionController::Base
  before_filter :set_user_time_zone
  before_filter :check_login
  before_filter :set_locale
  respond_to :html, :json

  # Set audit current user
  Audited.current_user_method = :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #rescue_from Exception, :with => :server_error
  def server_error(exception)
    ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver
    respond_to do |format|
      format.html { render template: 'errors/internal_server_error', layout: 'layouts/application', status: 500 }
      format.all  { render nothing: true, status: 500}
    end
  end

  rescue_from ActiveRecord::RecordNotFound, :with => :page_not_found
  rescue_from ActionController::RoutingError, :with => :page_not_found
  def page_not_found
    respond_to do |format|
      format.html { render template: 'errors/not_found', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end

  protected

    def set_user_time_zone
      Time.zone = current_user.time_zone if user_signed_in? && current_user.time_zone.present?
    end

    def devise_parameter_sanitizer
      if resource_class == User
        UserParameterSanitizer.new(User, :user, params) if !User.nil?
      else
        super # Use the default one
      end
    end

    def check_login
      # if company_signed_in?
      #   redirect_to company_root_path
      # end
      # if admin_signed_in?
      #   redirect_to hq_root_path
      # end
    end

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale
    end

end
