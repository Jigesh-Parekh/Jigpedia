require 'rails_helper'



RSpec.describe WikisController, type: :controller do
  
let(:my_user) {create(:user)}
let(:my_wiki) {create(:wiki)}


before :each do
  sign_in my_user 
end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns Wiki.all to wiki" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
    end

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_body = "NEWBODYNEWBODYYOOOOLLOOOO"

        put :update, id: my_wiki.id, wiki: {title: my_wiki.title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_body = "NEWBODYNEWBODYYOOOOLLOOOO"

        put :update, id: my_wiki.id, wiki: {title: my_wiki.title, body: new_body}

        expect(response).to redirect_to my_wiki
      end
    end
  describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, {id: my_wiki.id}
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wiki index" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
  end

end
