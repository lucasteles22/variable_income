class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    # devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
