module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(
      :name,:email, :password, :description, :avatar) }

    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(
      :name,:email, :password, :password_confirmation, :current_password, :description, :avatar) }
  end

end

DeviseController.send :include, DevisePermittedParameters
