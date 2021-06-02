class AddColumnAssignedPositionIdToUsersTable < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :assigned_position_id, :integer
  end
end
