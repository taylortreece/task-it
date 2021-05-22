class CreateTaskComments < ActiveRecord::Migration[6.1]
  def change
    create_table :task_comments do |t|
      t.string :content
      t.belongs_to :user
      t.belongs_to :task

      t.timestamps
    end
  end
end
