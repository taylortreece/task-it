class User < ApplicationRecord
    has_secure_password
    validates :first_name, presence: true
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

    accepts_nested_attributes_for :company
   # accepts_nested_attributes_for :positions

    def position_attributes=(position_attributes)
        self.build.positions(positon_attributes)
    end

    def full_name
        self.first_name + " " + self.last_name
    end

    def assigned_tasks
        Task.all.select { |t| t.assigned_task == self}
    end

    def assigned_positions
        Position.all.select { |p| p.assigned_position == self}
    end
end
