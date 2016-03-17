class WikisController < ApplicationController
  def index
   @wikis = policy_scope(Wiki)
  end

  def show
     @wiki = Wiki.find(params[:id])
     authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
    @collaborator = Collaborator.new
  end
  
  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki was saved!"
      redirect_to [@wiki]
    else
      flash[:notice] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end
  
  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated"
      redirect_to [:wiki]
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted."
      render :index
    else
      flash[:notice] = "There was an error deleting the wiki."
      render :show
    end
  end
  
  private
  
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
