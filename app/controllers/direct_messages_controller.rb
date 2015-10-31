class DirectMessagesController < ApplicationController
  before_action :set_direct_message, only: [:show, :destroy]
  before_filter :authenticate_user!
  # GET /direct_messages
  # GET /direct_messages.json
  def index
    @direct_messages = current_user.direct_messages.all
  end

  # GET /direct_messages/1
  # GET /direct_messages/1.json
  def show
  end

  # GET /direct_messages/new
  def new
    @direct_message = DirectMessage.new
  end

  # POST /direct_messages
  # POST /direct_messages.json
  def create

    @direct_message = DirectMessage.new(direct_message_params.merge(user: current_user, deliver: false))
    @direct_message.recipient = direct_message_params.with_indifferent_access.delete(:recipient).join(';') if direct_message_params.with_indifferent_access[:recipient].is_a? Array
    
    respond_to do |format|
      if @direct_message.save
        File.open('tmp/mylog.txt', 'w') do |f|
          f.write(@direct_message.recipient)
        end
        # current_user.as_twitter_rest_client.create_direct_message(@direct_message.recipient, @direct_message.text)
        format.html { redirect_to @direct_message, notice: 'Direct message was successfully created.' }
        format.json { render :show, status: :created, location: @direct_message }
      else
        format.html { render :new }
        format.json { render json: @direct_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /direct_messages/1
  # DELETE /direct_messages/1.json
  def destroy
    @direct_message.destroy
    respond_to do |format|
      format.html { redirect_to direct_messages_url, notice: 'Direct message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_direct_message
      @direct_message = DirectMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def direct_message_params
      params.require(:direct_message).permit(:text, recipient: {array: true})
    end
end
