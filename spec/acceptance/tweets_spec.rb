require 'rails_helper'
require "rspec_api_documentation"
require "rspec_api_documentation/dsl"

resource "Tweets" do
  get "/tweets" do
    example_request "Listing tweets" do
      do_request(page_for_sent: 1, page_for_not_sent: 1)
    end
  end

  post "/tweets" do

  end
end