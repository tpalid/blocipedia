module ApplicationHelper
    
    def markdown_to_html(markdown)
        renderer = Redcarpet::Render::HTML.new
        extensions = {fenced_code_blocks: true }
        redcarpet = Redcarpet::Markdown.new(renderer, extensions)
        (redcarpet.render markdown).html_safe
    end
    
    def wikis_needing_approval(user)
        wikis = Wiki.where(user_id: user.id).select {|wiki| wiki.collaborators.where(state: 'suggested').present? }
    end
    
    def display(user)
        user.name != '' ? user.name : user.email
    end

end
