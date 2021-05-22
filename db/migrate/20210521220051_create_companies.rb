class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :industry
      t.string :address
      t.string :city
      t.string :state
      t.string :phone_number
      t.string :email
      t.belongs_to :user

      t.timestamps
    end
  end
end
