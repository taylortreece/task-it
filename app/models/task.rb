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
        if self.assigned_user_id #update
           self.assigned_user.update(user_attributes.except(:user_param_value).with_defaults(user_id: self.user_id))
        elsif !self.assigned_user_id && !!user_attributes[:first_name] #create
           self.update(assigned_user_id: User.create(user_attributes.except(:user_param_value).with_defaults(user_id: self.user_id)).id)
        else
        end
        @user = self.assigned_user
    end

    def position_attributes=(position_attributes)
       if self.position.nil? && !!position_attributes[:title]
        self.update(position: Position.create(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: self.assigned_user.id)))
       elsif @user.assigned_position
        @user.assigned_position.update(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: @user.id))
        self.update(position: @user.assigned_position)
       else
        self.update(assigned_user_id: self.position.assigned_user_id)
       end
    end

    def assigned_user=(user)
        self.update(assigned_user_id: user.id)
    end

    def assigned_user
        User.find_by(id: self.assigned_user_id)
    end

    def late
        self.deadline < Date.today
    end
end
