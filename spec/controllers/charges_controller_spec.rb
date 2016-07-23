require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  
let(:my_user) {create(:user)}

before :each do
  sign_in my_user 
end

let(:stripe_helper) { StripeMock.create_test_helper }
before { StripeMock.start }
 after { StripeMock.stop }

  it "creates a stripe customer" do

    customer = Stripe::Customer.create({
      email: my_user.email,
      card: stripe_helper.generate_card_token
    })
    expect(customer.email).to eq(my_user.email)
  end

  it "mocks a declined card error" do
  # Prepares an error for the next create charge request
  StripeMock.prepare_card_error(:card_declined)

  expect { Stripe::Charge.create(amount: 1, currency: 'usd') }.to raise_error {|e|
    expect(e).to be_a Stripe::CardError
    expect(e.http_status).to eq(402)
    expect(e.code).to eq('card_declined')
  }
end

  describe "GET #charge" do
    it "returns http success" do
      get :charge
      expect(response).to redirect_to root_path
    end
  end

end
