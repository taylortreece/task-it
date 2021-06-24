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
    
    validates :first_name, :last_name, :email, :passowrd, presence: true
    validates :email, uniqueness: true

    accepts_nested_attributes_for :company
    accepts_nested_attributes_for :positions

    scope :team_leaders, -> { where(privilege: "Team Leader")}
    scope :admins, -> { where(privilege: "Admin")}
    scope :team_members, -> { where(privilege: "Team Member")}
    scope :leaders, -> { where.not(privilege: "Team Member" )}
    
    def team_attributes=(team_attributes)
        self.update(user_id: self.id) if self.user_id.nil? #assigning self as self's creator in signup
        @team = Team.find_by(id: team_attributes[:id]) unless #selecting from dropbox

        if team_attributes[:name]!=""
            if self.position #update
        self.team.update(team_attributes.except(:id).with_defaults(company: self.company, user_id: self.user_id)) ? @team = self.team : @team = nil
            else #create
        @team = Team.create(team_attributes.with_defaults(company: self.creator.company, user_id: self.user_id))
            end
        end
    end

    def position_attributes=(position_attributes)
        !!@team ? team_id = @team.id : team_id = position_attributes[:team_id]
        self.save if self.id.nil?

        if position_attributes[:title] != ""
            if self.position #update
                @team ? self.position.update(team_id: @team.id) : self.position.update(position_attributes.with_defaults(assigned_user_id: self.id))
            else #create
        self.update(assigned_position_id: Position.create(position_attributes.with_defaults(assigned_user_id: self.id, user_id: self.user_id, team_id: team_id)).id)
            end
        end
    end

    def full_name
        self.first_name + " " + self.last_name
    end

    def assigned_tasks
        position = Position.find_by(assigned_user_id: self.id)
        position.nil? ? position : self.position.tasks
    end

    def assigned_position
        Position.find_by(assigned_user_id: self.id)
    end

    def team
        position = Position.find_by(assigned_user_id: self.id)
        position.nil? ? position : position.team
    end

    def position
        Position.find_by(assigned_user_id: self.id)
    end

    def creator
        User.find_by(id: self.user_id) unless self.user_id.nil?
    end

    def user_company
        Company.find_by(user_id: self.user_id)
    end

    def completed_tasks
        self.position.tasks.completed
    end

    def incomplete_tasks
        self.position.tasks.incomplete
    end

    def ordered_tasks
        self.position.tasks.ordered
    end

    def team_leader
        self.privilege == "Team Leader"
    end

    def admin
        true if self.privilege == "Admin"
    end

    def leader
        self.privilege == "Team Leader" || self.privilege == "Admin"
    end
end
