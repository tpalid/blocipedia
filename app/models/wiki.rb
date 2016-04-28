class Wiki < ActiveRecord::Base
  include FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]
  belongs_to :user
  has_many :collaborators, dependent: :destroy
  has_many :users, through: :collaborators
  after_initialize :set_default_privacy

  #to ensure titles stay friendly, but are also unique
  def slug_candidates
    [ :title,
      [:title, :id]
    ]
 
  end
 
  #friendly_id's change when the title of a wiki changes
  def should_generate_new_friendly_id?
    title_changed?
  end
  
  def set_default_privacy
    self.private ||= false
  end
  
  def public?
    self.private == false
  end
  
  def private?
    self.private == true
  end
  
end
