class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate_user!,except: [:top, :about]

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def after_sign_up_path_for(resource)
    # flash[:notice] = "You have successfully signed up!"
    user_path(resource)
  end

  def after_sign_in_path_for(resource)
    # flash[:notice] = "Signed in successfully."
    user_path(resource) # ログイン後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    # flash[:notice] = "You have successfully logged out."
    root_path # ログアウト後に遷移するpathを設定
  end
end
