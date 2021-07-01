class Project < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :segments, dependent: :destroy
    has_many :teams, through: :segments
    has_many :project_comments, dependent: :destroy
    has_many :users, through: :project_comments

    validates :title, :description, presence: { message: "Project Fields must be filled and longer than 2 characters"}, length: { minimum: 2}
    validates :deadline, presence: { message: "You must assign a deadline to your Project"}

    scope :completed, -> { where(completed: true)}
    scope :incomplete, -> { where(completed: false)}
    scope :ordered, -> { order "deadline ASC" }
    scope :late, lambda { where('deadline < ?', Date.today).where(completed: false) }
    scope :search_title, -> (title) { where("title LIKE ?", "%#{title}%") }

    def ordered_segments
        self.segments.ordered
    end

    def completed_segments
        self.segments.ordered.completed
    end

    def incomplete_segments
        self.segments.ordered.incomplete
    end

    def late
        self.deadline < Date.today
    end
end
