class CollaboratorsController < ApplicationController
    autocomplete :user, :email
    
    def index
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborators = @wiki.collaborators
        @collaborating_users = @wiki.users
        @collaborator = Collaborator.new
        authorize @collaborators
    end
    
    def new
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @collaborator = Collaborator.new
    end
    
    
     def create
        @wiki = Wiki.friendly.find(params[:wiki_id])
        @user = User.find_by_email(params[:user_email])
        @state = params[:state]
        @name = name(@user)
        #to ensure user exists
        if @user
            @collaborator = Collaborator.new(
                user_id: @user.id,
                wiki_id: @wiki.id,
                state: @state)
            #save collaborator
            if @collaborator.save
                if @collaborator.state == "suggested"
                    flash[:notice]="#{@name} was suggested as a collaborator and is waiting for appproval by the wiki's creator."
                else
                    flash[:notice]="#{@name} was added as a collaborator."
                end
            else
                flash[:error]="There was an error adding #{@user.name} as a collaborator. Please check to see that they cannot already collaborate, and try again."
            end
        else
            flash[:error]= "#{params[:user_email]} is not a valid user."
        end
        redirect_to wiki_collaborators_path(@wiki)
    end
    
    def destroy
        @collaborator = Collaborator.find(params[:id])
        @user = User.find(@collaborator.user_id)
        @name = name(@user)
        
        puts @collaborator
        if @collaborator.destroy
            flash[:notice] = "#{@name} was deleted as a collaborator."
            redirect_to wiki_collaborators_path
        else
            flash[:notice] = "There was an error deleting the collaborator.  Please try again."
            redirect_to wiki_collaborators_path
        end
    end
    
    def edit
        @collaborator = Collaborator.find_by_wiki_id_and_user_id(params[:wiki_id], params[:id])
    end
    
    def update
        @collaborator = Collaborator.find(params[:id])
        # authorize @collaborator
        if @collaborator.update_attributes(collaborator_params)
            flash[:notice] = "Collaborator was approved."
            redirect_to wiki_collaborators_path
        elsif
            flash[:error] = "There was an error approving the collaborator." 
            redirect_to wiki_collaborators_path
        end
    end
    
    private
    
    def name(user)
        @name = view_context.display(user)
    end
 end