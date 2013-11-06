class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "You can't perform this action."
    redirect_to root_url
  end

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  protected

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:full_name, :email, :password, :password_confirmation, :login, :birthday, :country, :address, :city, :state, :zip, :role_id)
    end
  end
end
