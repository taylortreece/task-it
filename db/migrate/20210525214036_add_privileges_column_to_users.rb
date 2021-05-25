class AddPrivilegesColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :privilege, :string, default: "Admin"
  end
end
