class ApplicationController < ActionController::Base
  # unless Rails.application.config.consider_all_requests_local
  #   rescue_from ActionController::RoutingError, with: -> { render_404  }
  # end

  before_action :authorize

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: 'Пожалуйста, пройдите авторизацию'
      end
    end
end

