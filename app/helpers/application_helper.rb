module ApplicationHelper
    
    def markdown_to_html(markdown)
        renderer = Redcarpet::Render::HTML.new
        extensions = {fenced_code_blocks: true }
        redcarpet = Redcarpet::Markdown.new(renderer, extensions)
        (redcarpet.render markdown).html_safe
    end
    
    def wikis_needing_approval(user)
        @wikis = Wiki.where(user_id: user.id)
        @wikis.each do |wiki|
            @collaborators = wiki.collaborators
            if @collaborators.empty?
                return nil
            end
            @colllaborators.each do |collaborator|
                if collaborator.state == "suggested"
                    @wikis_needing_approval << collaborator.wiki_id
                end
            end
        end
        @wikis_needing_approval
    end
        @collaborators
    #     puts @wikis
    #     @wikis.each do |wiki|
    #         @collaborators = @wiki.collaborators
    #         @collaborators.each do |collaborator|
    #             if collaborator.wiki_id == wiki.id
    #                 raise "true"
    #             end
    #         end
    #     end
    # end
#         @wikis_needing_approval = []
#         @wikis.each do |wiki|
#             wiki.collaborators.each do |collaborator|
#                 puts collaborator
#                 if (collaborator.state == “suggested”) && (!@wikis_needing_approval.include?(wiki))
#     		        @wikis_needing_approval << wiki
#     		    end
#     	    end
#         end
#     @wikis_needing_approval
#   end


end
