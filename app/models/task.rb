class Task < ApplicationRecord
    belongs_to :segment
    belongs_to :position 
    belongs_to :user
    has_many :task_comments, dependent: :destroy
    has_many :users, through: :task_comments

    validates :title, :description, presence: { message: "Task Fields must be filled and longer than 2 characters"}, length: { minimum: 2}
    validates :deadline, presence: { message: "You must assign a deadline to your Task"}

    scope :completed, -> { where(completed: true)}
    scope :incomplete, -> { where(completed: false)}
    scope :ordered, -> { order "deadline ASC" }
    scope :late, lambda { where('deadline < ?', Date.today) }

    def user_attributes=(user_attributes)
        if self.assigned_user_id
        self.assigned_user.update(user_attributes.except(:user_param_value).with_defaults(user_id: self.user_id))
        @user = self.assigned_user
        elsif !self.assigned_user_id
          if !!user_attributes[:first_name]
        @user = User.create(user_attributes.except(:user_param_value).with_defaults(user_id: self.user_id))
           self.update(assigned_user_id: @user.id)
          end
        else
        end
    end

    def position_attributes=(position_attributes)
        # if a user creates a new task
       if self.position.nil? && !!position_attributes[:title]
        position = Position.create(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: self.assigned_user.id))
        self.position_id = position.id
        self.save
        elsif @user.assigned_position
        @user.assigned_position.update(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: @user.id))
        self.position = @user.assigned_position
        self.save
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

    def late
        self.deadline < Date.today
    end
end
