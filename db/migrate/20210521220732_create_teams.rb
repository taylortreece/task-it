class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :description
      t.belongs_to :company
      t.belongs_to :user

      t.timestamps
    end
  end
end
