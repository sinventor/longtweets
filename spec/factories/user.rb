FactoryGirl.define do
  factory :user do
    uid '8310926658'
    provider 'twitter'
    name 'Some Person'
    oauth_token ENV['user_oauth_token']
    oauth_secret ENV['user_oauth_secret']
    profile_image 'https://pbs.twimg.com/profile_images/1400480959/Sans_nom-2_400x400.png'

    factory :user_with_invalid_credentials do
      oauth_token '89373473-B3E910231KI3E34324JC565F'
      oauth_secret 'KD44324VMA23Kiw9kA23q'
    end
  end
end