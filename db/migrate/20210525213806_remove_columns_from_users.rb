class RemoveColumnsFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :admin, :boolean
    remove_column :users, :team_leader, :boolean
    remove_column :users, :team_member, :boolean
  end
end
