class AddStatusToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :status, :string
  end
end
