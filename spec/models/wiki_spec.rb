require 'rails_helper'

RSpec.describe Wiki, type: :model do

	let(:private) {false}
	let(:wiki) { create(:wiki)}
	let(:user) {create(:user, email: "1@gmail.com", password: "password")}
	describe "attributes" do 
		it "has a tile and a body" do
			expect(wiki).to have_attributes(title: wiki.title, body: wiki.body)
		end

	end

	describe "role filtration" do
	    before do
	      @public_topic = Wiki.create!(title: "tasdfasdfasdf", body: "asdfasdfasdfasdfasdf", private: false, user: user)
	      @private_topic = Wiki.create!(title: "tasdfasdfasdf", body: "asdfasdfasdfasdfasdf", private: true, user: user)
	    end


	    describe "User Visibility" do
	    	it "returns private false wikis to standard user" do
	    	
	    		user.standard!
	    		expect(Wiki.visible_to(user)).to eq [@public_topic]
	    	end

	    	it "returns private wiki assoucated with user and public wiki" do
	    	
	    		user.premium!
	    		#expect(Wiki.visible_to(user)).to eq(Wiki.where("(private = ?) OR ((private = ?) AND (user_id = ?))", false, true, user.id))
	    		expect(Wiki.visible_to(user)).to match_array [@public_topic, @private_topic]
	    	end

	    	it "returns private wiki assoucated with user and public wiki" do
	    	
	    		user.admin!
	    		expect(Wiki.visible_to(user)).to match_array [@public_topic, @private_topic]
	    	end
	    end
	end
end
