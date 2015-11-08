require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  render_views

  let!(:user1) { create(:user) }

  before :each do
    set_session_for_user(user1)
  end

  describe 'POST #create' do

    it 'creates a new tweet and performs worker to send it to the Twitter asynchronously' do
      expect{
        post :create, tweet: attributes_for(:tweet)
      }.to change(Tweet, :count).by(1)

      expect(TweetWorker).to have_enqueued_job(user1.id, Tweet.last.id)
    end

    it 'redirects to the new tweet' do
      post :create, tweet: attributes_for(:tweet)
      expect(response).to redirect_to(Tweet.last)
    end

  end

  describe 'GET #show' do
    let!(:t1) { create(:tweet, user: user1) }

    it "have created tweet content" do
      get :show, { id: t1.id }, { user_id: user1.id }
      expect(response).to have_http_status(200)
      expect(response.body).to have_content(t1.text)
    end
  end
end
