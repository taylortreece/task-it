class Task < ApplicationRecord
    belongs_to :segment
    belongs_to :position 
    belongs_to :user
    has_many :task_comments
    has_many :users, through: :task_comments

    def assigned_user=(user)
        @assigned_user = user
    end

    def assigned_user
        @assigned_user
    end

end
