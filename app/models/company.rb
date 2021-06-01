class Company < ApplicationRecord
    belongs_to :user
    has_many :teams
    has_many :projects

    validates :name, presence: true
end
