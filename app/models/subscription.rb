class Subscription < ActiveRecord::Base
  
  belongs_to :user
  before_save :upgrade_user
  before_destroy :downgrade_user, :downgrade_wikis
  
  def upgrade_user
    # @user = self.user
    # @user.update_attributes(role: "premium")
    #causing weird repeating loop!
  end
  
  def downgrade_user
    @user = self.user
    @user.update(role: "standard")
  end
  
  def downgrade_wikis
    @wikis = self.user.wikis
    @wikis.update_all(private: false)
  end
 
end
    