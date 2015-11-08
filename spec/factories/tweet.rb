FactoryGirl.define do
  factory :tweet do
    user
    text 'WordPress is able to get the capabilities of a given user, when needed.'

    factory :delivered_tweet do
      deliver true
    end
  end
end