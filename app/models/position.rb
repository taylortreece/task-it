class Position < ApplicationRecord
    belongs_to :user
    belongs_to :team
    has_many :tasks
    has_many :segments, through: :tasks

    validates :title, presence: true
    validates :description, presence: true
    
    def assigned_user=(user)
       self.assigned_user_id = user.id
    end

    def assigned_user
        User.find_by(id: self.assigned_user_id)
    end

end
