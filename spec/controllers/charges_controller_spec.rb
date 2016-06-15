require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  describe "GET #charge" do
    it "returns http success" do
      get :charge
      expect(response).to have_http_status(:success)
    end
  end

end
