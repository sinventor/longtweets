require 'rails_helper'

RSpec.describe DirectMessagesController, type: :controller do
  before :each do
    set_session_for_user(user1)
  end

  let!(:user1) { create(:user) }
  let!(:direct_message1) { create(:valid_direct_message, user: user1) }
  let!(:direct_message2) { create(:valid_direct_message, user: user1) }
  let!(:direct_message3) { create(:valid_direct_message, user: user1) }

  describe 'POST #create' do

    context 'with valid parameters' do
      it 'create direct message and send it to follower(s)' do
        post :create, direct_message: attributes_for(:valid_direct_message).merge(recipient: ['Person1', 'Person2'])
        expect(response).to have_http_status(302)
        direct_message = DirectMessage.last
        expect(DirectMessageSenderWorker).to have_enqueued_job(user1.id, direct_message.recipient, direct_message.text)
      end
    end

    context 'with missing attributes' do
      it 'does not save new direct message' do
        expect{ post :create, direct_message: attributes_for(:direct_message) }.not_to change(DirectMessage, :count)
      end

      it 're-renders the new direct_message' do
        post :create, direct_message: attributes_for(:direct_message)
        expect(response).to render_template(:new)
      end
    end

  end

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'populates an array of direct messages' do
      get :index
      expect(assigns(:direct_messages)).to eq([direct_message1, direct_message2, direct_message3])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested direct message to @direct_message' do
      get :show, id: direct_message2
      expect(assigns(:direct_message)).to eq(direct_message2)
    end

    it 'renders the #show view' do
      get :show, id: direct_message3
      expect(response).to render_template(:show)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the direct message (from database)' do
      expect{
        delete :destroy, id: direct_message1
      }.to change(DirectMessage, :count).by(-1)
    end
  end

end
