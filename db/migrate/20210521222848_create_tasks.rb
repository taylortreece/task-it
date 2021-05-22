class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.datetime :deadline
      t.string :description
      t.belongs_to :segment 
      t.belongs_to :position
      t.belongs_to :user

      t.timestamps
    end
  end
end
