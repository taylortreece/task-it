class User < ApplicationRecord
    has_one :company
    has_many :teams
    has_many :positions
    has_many :messages
    has_many :conversations, through: :messages
    has_many :task_comments
    has_many :segment_comments
    has_many :project_comments
    has_many :projects
    has_many :segments
    has_many :tasks

    # users need to have many projects, segments, and tasks.

    def assigned_tasks
    end

    def assigned_positions
    end
end
