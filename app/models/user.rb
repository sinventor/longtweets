class User < ActiveRecord::Base
  has_many :public_chat
  has_many :direct_messages
  has_many :tweets

	def tweet(tweet)
    client = as_twitter_rest_client
    tmp_file = "tmp/image.jpg"
    sent_twit = client.update_with_media(tweet[0,20],File.new(tmp_file))
    File.delete(tmp_file) if File.exists?(tmp_file)
    sent_twit
  end

  def twitter_name
    as_twitter_user.screen_name
  end

  def as_twitter_user
    as_twitter_rest_client.user
  end

  def as_twitter_rest_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.config.twitter_key
      config.consumer_secret = Rails.application.config.twitter_secret
      config.access_token = oauth_token
      config.access_token_secret = oauth_secret
    end
  end

  def get_followers
    as_twitter_rest_client.followers.each_with_index.collect do |follower, i|
      {
        id: i + 1,
        name: follower.screen_name
      }
    end
  end

	def self.from_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
			user.oauth_token = auth["credentials"]["token"]
			user.oauth_secret = auth["credentials"]["secret"]
			user.profile_image = auth["extra"]["raw_info"]["profile_image_url"]
			user.save!
		end
	end
end
