class Wiki < ActiveRecord::Base
  belongs_to :user
  
  #making private wikis only visable to creater- will have to change this when collaborators are added
  scope :visible_to, -> (user) { user == user ? all : where(public:true) }

 end
