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

  def referer
    Rails.application.routes.recognize_path(request.referer)
  end

  def cannot_go_back?
    referer[:action] == "edit" || request.referer.nil?
  end

  # Redirect to back
  # If :back is bad(model#edit or nil)
  # then redirect to options[:default]
  # If options[:default] is nil, redirect to model#index
  def redirect_to_back_or default_url, options = {} 
    url = request.referer
    default_url = controller_name.classify.constantize if default_url.nil?
    url = default_url if cannot_go_back?
    redirect_to url, options
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:avatar, :date_of_birth, :email, :name, :password, :password_confirmation, :current_password) 
    end
  end

end
