class Segment < ApplicationRecord
    belongs_to :project
    belongs_to :team
    belongs_to :user
    has_many :tasks
    has_many :positions, through: :tasks
    has_many :segment_comments
    has_many :users, through: :segment_comments

    validates :title, presence: true
    validates :deadline, presence: true
    validates :description, presence: true

    def team_attributes=(team_attributes)
        self.build_team(team_attributes.with_defaults(user_id: self.user_id, company_id: self.user.company.id))
    end
end
