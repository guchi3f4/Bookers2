class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :authenticate_user!,except: [:top, :about]

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  #form_withの設定:初期状態でremote
  Rails.application.config.action_view.form_with_generates_remote_forms = true
end
