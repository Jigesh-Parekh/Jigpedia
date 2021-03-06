class WikisController < ApplicationController
  #before_action :setter_wiki, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: :show


  def index
    @wikis = Wiki.visible_to(current_user)
    @collabwiki = current_user.collaborating_wikis

  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collabwiki = current_user.collaborating_wikis
    @user = User.find_by(params[:user_id]) #_by(email: params[:collaborator][:email]))

  end

  def create
     @wiki = Wiki.new(wiki_params)
     @wiki.creator = current_user



     if @wiki.save
       flash[:notice] = "Post was saved successfully."
       redirect_to @wiki
     else
 
       flash.now[:alert] = "There was an error saving the post. Please try again."
       render :new
     end
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Post was updated"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post please try again"
      render :edit
    end
  end

  def destroy
      @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the post"
      render :show
    end
  end
  
  def add_collaborator
    #@collaborator = Collaborator.new(params[:id])
    #@wiki = Wiki.find(params[:id])
    #if @wiki.save
    #  @wiki.collaborators = Collaborator.update_collaborators(params[:user][:collaborators])
    #  flash[:alert] = "Collaborator saved"
    #else  
    #  flash[:alert] = "Collaborator not saved, error -  please try again"
    #end
    @wiki = Wiki.find(params[:id])
    @user = User.find_by(email: params[:collaborator][:email])
      if @wiki.collaborators.include?(@user)
        flash[:alert] = "That user is already a collaborator."
      elsif @user.nil?
        flash[:alert] = "this user does not exist"
      else
        @wiki.collaborators << @user
      end
    redirect_to edit_wiki_path(@wiki)
  end  

  def remove_collaborator
   @wiki = Wiki.find(params[:id])
   collaboration = Collaboration.find_by(wiki_id: params[:id], user_id: params[:user_id])


     if collaboration.destroy
      flash[:notice] = "Collab Deleted"
      redirect_to edit_wiki_path(@wiki)
     else
      flash[:alert] = "Collab could not be deleted."
      redirect_to edit_wiki_path(@wiki)
     end
     
  end  

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, :user_id)
  end



  def authorize_user
      unless current_user.admin? || current_user.premium?
          flash[:alert] = "You must have upgraded privlidges to do that. please upgrade your account."
          redirect_to wikis_path
      end
  end

end
