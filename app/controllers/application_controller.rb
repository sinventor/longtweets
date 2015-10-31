class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  rescue_from Twitter::Error::TooManyRequests, with: :give_signal_to_wait

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

  private

  def give_signal_to_wait
    flash[:notice] = 'Было много запросов, в связи с политикой ограничения лимита к вызовам Twitter API, требуется переждать некоторое время'
    redirect_to root_path
  end

end
