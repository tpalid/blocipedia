class ChangeActiveUntilToInteger < ActiveRecord::Migration
  def change
      change_column :users, :active_until, :integer
  end
end
