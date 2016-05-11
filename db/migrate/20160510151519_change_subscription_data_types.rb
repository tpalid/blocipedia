class ChangeSubscriptionDataTypes < ActiveRecord::Migration
  def change
    change_column :subscriptions, :customer_id, :string
    change_column :subscriptions, :subscription_id, :string
  end
end
