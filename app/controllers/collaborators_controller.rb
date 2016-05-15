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
        if params[:approve]
            @wiki.edit
        else
            if current_user == @wiki.user
                @state = params[:state]
            else
                @state = "suggested"
            end
                #to ensure user exists
                if @user
                    #check to see if collaborator already exits
                    @collaborator = Collaborator.find_by(
                        user_id: @user.id,
                        wiki_id: @wiki.id
                        )
                        @name = !@user.name.blank? ? @user.name : @user.email
                    if @collaborator
                        flash[:error]="#{@name} is already a collaborator on #{@wiki.title}."
                    #create collaborator
                    elsif @user == current_user
                         flash[:error]="You can already collaborate on this wiki!"
                    else
                        @collaborator = Collaborator.create(
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
                            flash[:error]="There was an error adding #{@user.name} as a collaborator. Please try again."
                        end
                    end
                else
                    flash[:error]= "#{params[:user_email]} is not a valid user."
                end
            redirect_to wiki_collaborators_path(@wiki)
        end
    end
    
    def destroy
        @collaborator = Collaborator.find(params[:id])
        @user = User.find(@collaborator.user_id)
        @name = !@user.name.blank? ? @user.name : @user.email
        
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
        if @collaborator.update_attributes(collaborator_params)
            flash[:notice] = "Collaborator was approved."
            redirect_to wiki_collaborators_path
        elsif
            flash[:error] = "There was an error approving the collaborator." 
            redirect_to wiki_collaborators_path
        end
    end
    
    
    def destroy_multiple
        Collaborator.destroy(params[:collaborator_ids])
        redirect_to wiki_collaborators_path
    end
            
    private
    
    def collaborator_params(my_params)
        my_params.permit(:user_id)
    end
    
    def collaborator_params
        params.require(:collaborator).permit(:user_id, :wiki_id, :state)
    end

    #strong params?
    #nest this in a way that I get information from wiki?- checking on blocit
end