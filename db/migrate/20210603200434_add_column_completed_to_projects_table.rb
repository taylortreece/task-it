class AddColumnCompletedToProjectsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :completed, :boolean, default: false
  end
end
