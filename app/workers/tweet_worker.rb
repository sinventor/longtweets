class TweetWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'often'

  def perform(user_id, tweet_id)
    user = User.find(user_id)
    tweet = Tweet.find(tweet_id)
    Magick::TTIConverter.new('tmp/').make_image(tweet.text, file_name: 'img2.jpg')
    tweet.update_attribute(:deliver, true)
    src_tweet = user.tweet(tweet.text)
    File.open("tmp/twet.txt", "w") do |f|
      f.write(src_tweet.attrs)
    end
  end
end