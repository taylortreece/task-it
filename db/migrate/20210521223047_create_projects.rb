class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.datetime :deadline
      t.string :description
      t.belongs_to :company
      t.belongs_to :user

      t.timestamps
    end
  end
end
