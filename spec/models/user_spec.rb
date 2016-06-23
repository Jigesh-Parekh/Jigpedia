require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}
 
  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eq("standard")
    end

  context "standard user" do
  	before do
  		user.standard!
  	end

    it "returns true for standard" do
      expect(user.standard?).to be_truthy
    end

    it "returns false for premium" do
      expect(user.premium?).to be_falsey
    end

    it "returns false for admin" do
      expect(user.admin?).to be_falsey
    end
  end

  context "premium user" do
  	before do
  		user.premium!
  	end

    it "returns true for premium" do
      expect(user.premium?).to be_truthy
    end

    it "returns false for standard" do
      expect(user.standard?).to be_falsey
    end

    it "returns false for admin" do
      expect(user.admin?).to be_falsey
    end
  end

  context "admin user" do
    before do
      user.admin!
    end

       it "returns false for #standard?" do
         expect(user.standard?).to be_falsey
       end
       it "returns true for #premium?" do
         expect(user.premium?).to be_falsey
       end
       it "returns true for #admin?" do
         expect(user.admin?).to be_truthy
       end
  end
end
end
