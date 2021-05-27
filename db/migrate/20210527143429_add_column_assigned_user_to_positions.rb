class AddColumnAssignedUserToPositions < ActiveRecord::Migration[6.1]
  def change
    add_column :positions, :assigned_user_id, :integer
  end
end
