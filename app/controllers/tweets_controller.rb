class TweetsController < ApplicationController
  include TweetsHelper

  def new
  end

  def show
  end

  def create
    if text_to_image(twitter_params[:msg])
      tweet(twitter_params[:msg])
      redirect_to tweets_show_path
    else
      redirect_to tweets_new_path, alert: 'К сожалению, ваш твит не удалось отправить. Попробуйте еще раз'			
    end
  end

  private
    def twitter_params
      params.require(:tweet).permit(:msg)
    end
end
