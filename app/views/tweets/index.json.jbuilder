json.array!(@sent_tweets) do |tweet|
  json.extract! tweet, :id, :text, :user_id
  json.url tweet_url(tweet, format: :json)
end

json.array!(@not_sent_tweets) do |tweet|
  json.extract! tweet, :id, :text, :user_id
  json.url tweet_url(tweet, format: :json)
end