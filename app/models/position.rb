class Position < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_many :tasks
    has_many :segments, through: :tasks

    def assign_user
    end

end
