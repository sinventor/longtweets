class DirectMessageSenderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, queue: 'sender'

  def perform(sender_id, recipients_str, text, options = {})
    separator = options[:separator] || ';'
    user = User.find(sender_id)
    recipients = recipients_str.split(separator)
    twitter_rest_client = user.as_twitter_rest_client

    recipients.each do |rec|
      twitter_rest_client.create_direct_message(rec, text)
    end
  end

end