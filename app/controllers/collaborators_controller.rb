class CollaboratorsController < ApplicationController
    
    def index
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborators = Collaborator.where(wiki_id: @wiki.id)
        @user_collaborators = User.where(id: @collaborators.pluck(:user_id))
        #need to find a way to delete users from the index- but I am iterating through a list of USERS in the index#view, not a list of collaborators. could I make this into a hash?
    end
    
    def new
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborator = Collaborator.new
    end
    
    def create
        @user = User.find_by_email(params[:email])
        @wiki = Wiki.friendly.find(params[:wiki_id])
        
        #to ensure user exists
        if @user
            @collaborator = Collaborator.create(
                user_id: @user.id,
                wiki_id: @wiki.id)
            if @collaborator.save
                flash[:notice] = "Collaborator was saved."
                redirect_to [@wiki]
            else
                flash[:error] = "There was an error saving the collaborator.  Please try again."
                render :new
            end
        else
            flash[:error] = "That user does not exist."
            render :new
        end
    end
    
    def destroy
        @wiki = Wiki.friendly.find(params[:id])
        @collaborator = Collaborator.find(params[:user_id])
        if @collaborator.destroy
            flash[:notice] = "The collaborator was deleted." #change this to make more sense!
            render :index
        elsif 
            flash[:notice] = "There was an error deleting the collaborator.  Please try again."
            render :index
        end
    end
            
    private
    
    
    #strong params?
    #nest this in a way that I get information from wiki?- checking on blocit
end