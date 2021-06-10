class Team < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :positions, dependent: :destroy
    has_many :users, through: :positions
    has_many :segments, dependent: :destroy
    has_many :projects, through: :segments

    validates :title, :description, presence: { message: "Position Fields must be filled and longer than 2 characters"}, length: { minimum: 2}

    def completed_segments
        self.segments.completed
    end

    def incomplete_segments
        self.segments.incomplete
    end

    def ordered_segments
        self.segments.ordered
    end

    def leaders
        self.positions.select {|p| p.assigned_user.privilege != "Team Member" }.map {|p| p.assigned_user}
    end
end
