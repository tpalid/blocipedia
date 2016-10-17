class WikisController < ApplicationController
  require 'will_paginate/array'
  
  def index
   @wikis = policy_scope(Wiki).paginate(page: params[:page], per_page: 10)
  end

  def show
    @wiki = Wiki.friendly.find(params[:id])
    if request.path != wiki_path(@wiki)
      return redirect_to @wiki, :status => :moved_permanently
    end
    #do I need to do this for edit, update, destroy?
     authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end
  
  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki was saved!"
      if @wiki.private?
        @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: current_user.id, state: "creator")
        @collaborator.save
        redirect_to [@wiki, :collaborators]
      else
        redirect_to [@wiki]
      end
    else
      flash[:notice] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end
  
  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
  end
  
  def update
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.update_attributes(wiki_params)
      if @wiki.private?
        @collaborator = Collaborator.new(wiki_id: @wiki.id, user_id: current_user.id, state: "creator")
        @collaborator.save!
      end
      flash[:notice] = "Wiki was updated"
      redirect_to [@wiki]
    else
      flash[:error] = "There was an error updating th
      e wiki. Please try again."
      render :edit
    end
  end
  
  def destroy
    @wiki = Wiki.friendly.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted."
      redirect_to wikis_path
    else
      flash[:notice] = "There was an error deleting the wiki."
      redirect_to [@wiki]
    end
  end
  
  private
  

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
