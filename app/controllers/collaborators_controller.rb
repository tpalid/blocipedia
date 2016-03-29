class CollaboratorsController < ApplicationController
    autocomplete :user, :email
    
    def index
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborator = Collaborator.new
        @collaborating_users = @wiki.users
    end
    
    def new
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborator = Collaborator.new
    end
    
    def create
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @user = User.find_by_email(params[:user_email])
            if @user
                @collaborator = Collaborator.find_by(
                    user_id: @user.id,
                    wiki_id: @wiki.id
                    )
                if @collaborator
                    flash[:error]="#{@user.name} is already a collaborator on #{@wiki.title}."
                else
                    @collaborator = Collaborator.create(
                        user_id: @user.id,
                        wiki_id: @wiki.id)
                    if @collaborator.save
                        flash[:notice]="#{@user.name} was added as a collaborator."
                    else
                        flash[:error]="There was an error adding #{@user.name} as a collaborator. Please try again."
                    end
                end
            else
                flash[:error]= "#{params[:email]} is not a valid user."
            end
        redirect_to wiki_collaborators_path(@wiki)
    end
    
    def destroy
        @collaborator = Collaborator.find_by_wiki_id_and_user_id(params[:wiki_id], params[:id])
        if @collaborator.destroy
            flash[:notice] = "The collaborator was deleted."
            redirect_to wiki_collaborators_path
        else
            flash[:notice] = "There was an error deleting the collaborator.  Please try again."
            redirect_to wiki_collaborators_path
        end
    end
            
    private
    
    def collaborator_params(my_params)
        my_params.permit(:user_id)
    end
    #strong params?
    #nest this in a way that I get information from wiki?- checking on blocit
end