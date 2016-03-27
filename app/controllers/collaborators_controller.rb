class CollaboratorsController < ApplicationController
    
    def index
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborating_users = @wiki.users
    end
    
    def new
        @wiki = Wiki.friendly.find(params[:wiki_id])
    end
    
    def create
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @nonexistant_users_emails = []
        @unsavable_collaborators = []
        params[:emails].each do |email|
            if email != ""
                @user = User.find_by_email(email)
                if @user
                    @collaborator = Collaborator.find_or_create_by(
                        user_id: @user.id,
                        wiki_id: @wiki.id)
                    if @collaborator.save!
            
                    else
                        @unsavable_collaborators << email
                    end
                else
                    @nonexistant_users_emails << email
                end
            end
        end
                
        if @unsavable_collaborators.empty? == false
            flash[:error]= " #{@unsavable_collaborators.join " and " } could not be saved"
        elsif @nonexistant_users_emails.empty? == false
            flash[:error]= " #{@nonexistant_users_emails.join " and "} do not exist"
        else
            flash[:notice] ="The collaborators were saved successfully"
        end
        
    
        redirect_to @wiki
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