class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /tweets
  # GET /tweets.json
  def index
    @sent_tweets = Tweet.where(deliver: true).page(params[:page_for_sent])
    @not_sent_tweets = Tweet.where.not(deliver: true).page(params[:page_for_not_sent])
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
    Tweet.find(params[:id]).update_attribute(:deliver, !true)
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params.merge(user: current_user))

    respond_to do |format|
      if @tweet.save
        TweetWorker.perform_async(Rails.env.test? ? 1 : current_user.id, @tweet.id)
        # WebsocketRails[:tweets].trigger 'deliver', { text: 'dsdsds' }
        format.html { redirect_to @tweet, notice: 'Твит был успешно создан и скоро будет виден в сети.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:text)
    end
end
