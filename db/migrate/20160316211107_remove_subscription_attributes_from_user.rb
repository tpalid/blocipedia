class RemoveSubscriptionAttributesFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :active_until, :integer
    remove_column :users, :subscription_id, :integer
    remove_column :users, :customer_id, :integer
  end
end
