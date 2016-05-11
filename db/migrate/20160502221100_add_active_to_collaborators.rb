class AddActiveToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :state, :string
  end
end
