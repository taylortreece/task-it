class Company < ApplicationRecord
    belongs_to :user
    has_many :employees, :class_name => "User", :foreign_key => "user_id"
    has_many :teams, dependent: :destroy
    has_many :projects, dependent: :destroy

    validates :name, :industry, :address, :city, :state, :phone_number, :email, presence: { message: "All fields are required and must be at least two characters."}, length: { minimum: 2 }
end
