class User < ApplicationRecord
    has_secure_password
    
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
    
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true, uniqueness: true

    accepts_nested_attributes_for :company
    accepts_nested_attributes_for :positions
    

    def position_attributes=(position_attributes)
        self.save
        if !self.assigned_position.nil?
            self.assigned_position.update(position_attributes.with_defaults(assigned_user_id: self.id))
        else
            position = self.positions.build(position_attributes.with_defaults(assigned_user_id: self.id))
            position.user_id = self.user_id # I'm not sure why this wouldn't work within the #with_defaults method, but hard coding it was required.
            position.save
            self.assigned_position_id = position.id
        end
    end

    def full_name
        self.first_name + " " + self.last_name
    end

    def assigned_tasks
        Task.all.select { |t| t.assigned_task == self}
    end

    def assigned_position
        Position.all.find_by(id: self.assigned_position_id)
    end
end
