class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale_from_params

  helper_method :current_user
  rescue_from Twitter::Error::TooManyRequests, with: :give_signal_to_wait

  protected

  def default_url_options
    { locale: I18n.locale }
  end

  def set_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        I18n.locale = I18n.default_locale
      end
    end
  end

  private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      nil
    end
  end


  def authenticate_user!
    if !current_user
      redirect_to root_url, alert: 'You need to sign in for acces to this page'
    end
  end

  def give_signal_to_wait
    flash[:notice] = 'Было много запросов, в связи с политикой ограничения лимита к вызовам Twitter API, требуется переждать некоторое время'
    redirect_to root_path
  end
end
