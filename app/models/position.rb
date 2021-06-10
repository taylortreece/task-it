class Position < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_many :tasks, dependent: :destroy
    has_many :segments, through: :tasks

    validates :title, :description, presence: { message: "Position Fields must be filled and longer than 2 characters"}, length: { minimum: 2}

    def assigned_user=(user)
       self.assigned_user_id = user.id
    end

    def assigned_user
        User.find_by(id: self.assigned_user_id)
    end

    def team
        Team.find_by(id: self.team_id)
    end
end
