class ApiController < ApplicationController
  before_action :authenticate_user!
  # self.responder = ApiResponder
  # respond_to :json
end