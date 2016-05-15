u = User.where(id: 1).first
w = Wiki.where(user_id: 1)
w1 = w.first
s = Subscription.new(user_id: 1)
c = Collaborator.new(wiki_id: w1)
