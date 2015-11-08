class Api::V1::RelationshipsController < ApiController
  def index
    i = 0
    # @followers = current_user.as_twitter_rest_client.followers.collect do |t|
    #   {
    #     id: i += 1,
    #     name: t.screen_name
    #   }
    # end
    q = params[:q]
    @followers = current_user.get_followers.reject { |follower| follower[:name].match(/#{q}/).nil? }
    render json: @followers
  end
end