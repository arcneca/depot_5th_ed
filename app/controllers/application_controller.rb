class ApplicationController < ActionController::Base
  before_action :authorize, :set_date_loaded, :set_i18n_locale_from_params
  protect_from_forgery with: :exception

  protected

    def authorize
      unless request.format == Mime[:html]
        authenticate_or_request_with_http_basic do |n, p|
          user = User.find_by_name(n)
          if user and user.authenticate(p)
            session[:user_id] = user.id
          end
        end
      end

      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] =
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def set_date_loaded
      @date_loaded = Time.now
    end
end
