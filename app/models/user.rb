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
    
    validates :last_name, presence: { message: "All fields are required and must be at least two characters."}, length: { minimum: 2 }
    validates :email, presence: true, uniqueness: true

    accepts_nested_attributes_for :company
    accepts_nested_attributes_for :positions

    scope :team_leaders, -> { where(privilege: "Team Leader")}
    scope :admins, -> { where(privilege: "Admin")}
    scope :team_members, -> { where(privilege: "Team Member")}
    scope :leaders, -> { where.not(privilege: "Team Member" )}
    
    def team_attributes=(team_attributes)
        self.update(user_id: self.id) if self.user_id.nil?
        binding.pry
        # selecting a team from a dropbox
        if !team_attributes[:id].nil?
            @team = Team.find_by(id: team_attributes[:id]) 
        # updating an existing team
        elsif self.position && team_attributes[:name]!="" && team_attributes[:profile].nil?
        self.team.update(team_attributes.with_defaults(company: self.company, user_id: self.user_id))
                @team = self.team
        else
        # creating a team from the profile page
            if team_attributes[:profile] == "profile"
                @team = Team.create(name: team_attributes[:name], description: team_attributes[:description], company: self.creator.company, user_id: self.user_id )
        # creating a team
            elsif team_attributes[:name] != ''
                @team = Team.new(team_attributes.except(:profile).with_defaults(company: self.company, user_id: self.user_id))
                @team.save
            else
            end
        end
        self.update(assigned_position_id: @position.id) if self.position

        if @position
        @position.update(team_id: @team.id) if @team 
        end
    end

    def position_attributes=(position_attributes)
            self.save
        if position_attributes[:title] != ""
            if self.position
                @position = self.assigned_position
                @position.update(team_id: @team.id) if @team
                @position.save
                self.position.update(position_attributes.with_defaults(assigned_user_id: self.id))
            else
                @position = self.positions.build(position_attributes.with_defaults(assigned_user_id: self.id))
                @position.update(user_id: self.user_id) # I'm not sure why this wouldn't work within the #with_defaults method, but hard coding it was required.
                @position.update(team_id: @team) if @team
                self.update(assigned_position_id: @position.id)
                @position.save
            end
        end
    end

    def full_name
        self.first_name + " " + self.last_name
    end

    def assigned_tasks
        Task.all.select { |t| t.assigned_user == self}
    end

    def assigned_position
        Position.find_by(assigned_user_id: self.id)
    end

    def team
        Position.find_by(assigned_user_id: self.id).team
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
