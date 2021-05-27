class Position < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_many :tasks
    has_many :segments, through: :tasks

    def assigned_user=(id)
       self.assigned_user_id = id
    end

    def assigned_user
        User.find_by(id: self.assigned_user_id)
    end

end
