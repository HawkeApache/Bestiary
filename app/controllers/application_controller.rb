class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:displayname, :firstname, :lastname, :email, :password])
    devise_parameter_sanitizer.permit(:account_update, keys: [:displayname, :firstname, :lastname, :email, :password, :current_password])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

end
