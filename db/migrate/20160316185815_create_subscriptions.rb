class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :customer_id
      t.integer :subscription_id
      t.integer :current_period_end
      t.references :user

      t.timestamps null: false
    end
  end
end
