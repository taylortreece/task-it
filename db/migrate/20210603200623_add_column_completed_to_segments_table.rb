class AddColumnCompletedToSegmentsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :completed, :boolean, default: false
  end
end
