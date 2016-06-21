class WikisController < ApplicationController
  before_action :authenticate_user!, except: :show
  #@wiki.current_user = current_user
  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])

      if @wiki.private = true && current_user.standard? #tried multiple forms of logic, either all wikis viewable or none are, suspect db issue as well 
       flash[:alert] = "You must be Upgraded in to view private topics."
       redirect_to wikis_path
     end
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def create
     @wiki = Wiki.new(wiki_params)
     #@wiki.title = params[:wiki][:title]
     #@wiki.body = params[:wiki][:body]


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
  

  private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
      unless current_user.admin? || current_user.premium?
          flash[:alert] = "You must have upgraded privlidges to do that. please upgrade your account."
          redirect_to wikis_path
      end
  end

end