require 'rails_helper'

RSpec.describe Wiki, type: :model do

	let(:private) {false}
	let(:wiki) { create(:wiki)}

	describe "attributes" do 
		it "has a tile and a body" do
			expect(wiki).to have_attributes(title: wiki.title, body: wiki.body)
		end

	end

	describe "role filtration" do
	    before do
	      @public_topic = Wiki.create!(title: "tasdfasdfasdf", body: "asdfasdfasdfasdfasdf", private: false)
	      @private_topic = Wiki.create!(title: "tasdfasdfasdf", body: "asdfasdfasdfasdfasdf", private: true)
	    end


	    describe "User Visibility" do
	    	it "returns private false wikis to standard user" do
	    		user = User.new
	    		user.email = "1@gmail.com"
	    		user.password = "password"
	    		user.standard!
	    		expect(Wiki.visible_to(user)).to eq(Wiki.where(private: false))
	    	end

	    	it "returns private wiki assoucated with user and public wiki" do
	    		user = User.new
	    		user.email = "1@gmail.com"
	    		user.password = "password"
	    		user.premium!
	    		expect(Wiki.visible_to(user)).to eq(Wiki.where("(private = ?) OR ((private = ?) AND (user_id = ?))", false, true, user.id))
	    	end

	    	it "returns private wiki assoucated with user and public wiki" do
	    		user = User.new
	    		user.email = "1@gmail.com"
	    		user.password = "password"
	    		user.admin!
	    		expect(Wiki.visible_to(user)).to eq(Wiki.all)
	    	end
	    end
	end
end
