class CollaboratorsController < ApplicationController
  before_action :setter_wiki
  def index
     @wikis = policy_scope(Wiki)
  end

  def show
    @collaborator = @wiki.colaborators.new(user_id: params[:user_id])
  end

 # def new
 # end

  #def edit  
  #end

  #def update
  #end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:alert] = "Collaborator removed"
    else
      pass
    end

    redirect_to wiki_collaborators_path(@wiki)
  end

  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])

    if @collaborator.save
      flash[:alert] = "Collaborator added Successfully to #{@wiki.title}"
    else
      flash[:notice] = "OThe collaborator could not be added. Try Again"
    end

    redirect_to wiki_collaborators_path(@wiki)
  end

  private
  def setter_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
