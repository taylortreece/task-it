class CreateSegmentComments < ActiveRecord::Migration[6.1]
  def change
    create_table :segment_comments do |t|
      t.string :content
      t.belongs_to :user
      t.belongs_to :segment

      t.timestamps
    end
  end
end
