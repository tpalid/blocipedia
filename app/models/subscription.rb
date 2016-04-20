class Subscription < ActiveRecord::Base
  require 'date'
  
  belongs_to :user
  after_save :upgrade_user
  before_destroy :downgrade_user, :downgrade_wikis
  
  def upgrade_user
    @user = self.user
    @user.update_attributes(role: "premium")
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
  
  def period_end_date
    # self.current_period_end.at(seconds_since_epoch_integer).to_datetime
    # DateTime.strptime("#{self.current_period_end}", '%s')
    Time.at(self.current_period_end).strftime('%B %e, %Y')
  end
  
end
    