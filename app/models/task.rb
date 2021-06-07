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
       if user_attributes[:user_param_value] == "edit_user"
        self.assigned_user.update(user_attributes.except(:user_param_value).with_defaults(user_id: self.user_id))
        @user = self.assigned_user
       elsif user_attributes[:user_param_value] == "create_user"
          if !!user_attributes[:first_name]
           @user = User.create(user_attributes.except(:user_param_value).with_defaults(user_id: self.user_id))
           self.assigned_user_id = @user.id
          end
        else
        end
    end

    def position_attributes=(position_attributes)
        # if a user creates a new task
       if self.position.nil? && !!position_attributes[:title]
        self.position = Position.create(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: self.assigned_user.id))
       elsif @user.assigned_position
        @user.assigned_position.update(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id, assigned_user_id: @user.id))
        @user.save
        self.position = @user.assigned_position
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
