class AddStripeInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :string
    add_column :users, :subscription_id, :string
    add_column :users, :active_until, :datetime
  end
end
