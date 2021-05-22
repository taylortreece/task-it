class CreatePositions < ActiveRecord::Migration[6.1]
  def change
    create_table :positions do |t|
      t.string :title
      t.string :description
      t.belongs_to :team
      t.belongs_to :user

      t.timestamps
    end
  end
end
