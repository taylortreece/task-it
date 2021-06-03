class Task < ApplicationRecord
    belongs_to :segment
    belongs_to :position 
    belongs_to :user
    has_many :task_comments, dependent: :destroy
    has_many :users, through: :task_comments

    validates :title, presence: true
    validates :deadline, presence: true
    validates :description, presence: true

    def user_attributes=(user_attributes)
        #if a new user and position is created for a task.
       if !!user_attributes[:first_name]
        @user = User.create(user_attributes.with_defaults(user_id: self.user_id))
        self.assigned_user_id = @user.id
       end
       # a user is not updated through this method.
    end

    def position_attributes=(position_attributes)
        # if a user creates a new task
       if self.position.nil? && !!position_attributes[:title]
        self.position = Position.create(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: self.assigned_user.id))
        #if a person updates a task with a newly created team_member and position
       elsif self.position && position_attributes[:title] != ""
        self.position = Position.create(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: self.assigned_user.id))
        #if a person selects to update a task's position from the drop down box
       else
        self.assigned_user_id = self.position.assigned_user_id
       end
    end

    def assigned_user=(user)
        self.assigned_user_id = user.id
        self.save
    end

    def assigned_user
        User.find_by(id: self.assigned_user_id)
    end
end
