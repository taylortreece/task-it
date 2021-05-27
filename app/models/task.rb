class Task < ApplicationRecord
    belongs_to :segment
    belongs_to :position 
    belongs_to :user
    has_many :task_comments
    has_many :users, through: :task_comments

    accepts_nested_attributes_for :user
    accepts_nested_attributes_for :position

    def position_attributes=(position_attributes)
        self.position = self.build_position(position_attributes.with_defaults(user_id: self.user_id, team_id: self.segment.team.id))
        self.save
        binding.pry
    end

    def user_attributes=(user_attributes)
        user = User.new(user_attributes)
        user.save
        assigned_user = user
        binding.pry
    end

    def assigned_user=(user)
        self.assigned_user = user
    end

    def assigned_user
        self.assigned_user
    end

end
