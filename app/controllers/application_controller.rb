class ApplicationController < ActionController::Base

  # CanCan used for autorizing users to actions
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # Primary layout tpl
  layout "main"

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:account_update) |= :name, :date_of_birth
    #devise_parameter_sanitizer.for(:account_update) << :date_of_birth
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:avatar, :date_of_birth, :email, :name, :password, :password_confirmation, :current_password) 
    end
  end

end
