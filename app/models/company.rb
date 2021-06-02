class Company < ApplicationRecord
    belongs_to :user
    has_many :employees, :class_name => "User", :foreign_key => "user_id"
    has_many :teams
    has_many :projects

    validates :name, presence: true
end
