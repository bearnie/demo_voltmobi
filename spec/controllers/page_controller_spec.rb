require 'rails_helper'

RSpec.describe PageController, type: :controller do

  before do
    sign_in nil
  end

  render_views

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
