require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users" do
    it "can't watch list of users" do
      get users_path
      expect(response).to have_http_status(302)
    end
  end

end
