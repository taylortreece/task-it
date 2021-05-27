class AddColumnAssignedUserToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :assigned_user_id, :integer
  end
end
