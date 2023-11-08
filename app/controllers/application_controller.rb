# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_user_balance

  helper FlashHelper


  private

  def load_user_balance
    @balance = current_user&.balance
  end

  private

  def after_sign_in_path_for(resource)
    if resource.is_a?(Administrator)
      administrator_dashboard_path
    else
      super
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :cpf, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :cpf])
  end
end
