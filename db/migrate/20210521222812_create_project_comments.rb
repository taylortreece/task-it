class CreateProjectComments < ActiveRecord::Migration[6.1]
  def change
    create_table :project_comments do |t|
      t.string :content
      t.belongs_to :user
      t.belongs_to :project

      t.timestamps
    end
  end
end
