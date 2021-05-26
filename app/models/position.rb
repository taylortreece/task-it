class Position < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_many :tasks
    has_many :segments, through: :tasks

    def assigned_user=(user)
        @assigned_user = user
    end

    def assigned_user
        @assigned_user
    end

end
