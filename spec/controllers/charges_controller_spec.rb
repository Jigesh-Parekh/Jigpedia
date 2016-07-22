require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  
let(:my_user) {create(:user)}

before :each do
  sign_in my_user 
end


  describe "GET #charge" do
    it "returns http success" do
      get :charge
      expect(response).to redirect_to root_path
    end
  end

end
