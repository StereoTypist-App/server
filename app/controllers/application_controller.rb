class ApplicationController < ActionController::Base
    before_action :devise_sanitize_params, if: :devise_controller?

    def devise_sanitize_params
        registration_params = [:display_name, :email, :password, :password_confirmation]

        if params[:action] == 'update' then
            devise_parameter_sanitizer.permit(:account_update, keys: registration_params << :current_password)
        elsif params[:action] == 'create' then
            devise_parameter_sanitizer.permit(:sign_up, keys: registration_params)
        end
    end
end
