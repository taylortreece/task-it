class CreateConversations < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.integer :subject_id
      t.string :subject_title
      t.string :subject_class

      t.timestamps
    end
  end
end
