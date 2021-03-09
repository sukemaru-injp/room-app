class ApplicationController < ActionController::Base
  before_action :configure_permitted_parametrs, if: :devise_controller?

  private
  def configure_permitted_parametrs
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :sex_id])
  end

end
