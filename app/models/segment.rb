class Segment < ApplicationRecord
    belongs_to :project
    belongs_to :team
    belongs_to :user
    has_many :tasks, dependent: :destroy
    has_many :positions, through: :tasks
    has_many :segment_comments, dependent: :destroy
    has_many :users, through: :segment_comments

    validates :title, :description, presence: { message: "Segment Fields must be filled and longer than 2 characters"}, length: { minimum: 2}
    validates :deadline, presence: { message: "You must assign a deadline to your Segment"}

    scope :completed, -> { where(completed: true)}
    scope :incomplete, -> { where(completed: false)}
    scope :ordered, -> { order "deadline ASC" }
    scope :late, lambda { where('deadline < ?', Date.today) }

    def team_attributes=(team_attributes)
        self.build_team(team_attributes.with_defaults(user_id: self.user_id, company_id: self.user.company.id))
    end

    def ordered_tasks
        self.tasks.ordered
    end

    def completed_tasks
        self.tasks.ordered.completed
    end

    def incomplete_tasks
        self.tasks.ordered.incomplete
    end

    def late
        self.deadline < Date.today
    end
end
