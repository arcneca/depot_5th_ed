class ApplicationController < ActionController::Base
  before_action :authorize, :set_date_loaded
  protect_from_forgery with: :exception

  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

  private

    def set_date_loaded
      @date_loaded = Time.now
    end
end
