class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.string :title
      t.datetime :deadline
      t.string :description
      t.belongs_to :project 
      t.belongs_to :team
      t.belongs_to :user

      t.timestamps
    end
  end
end
