class ApplicationController < ActionController::Base
    before_action :logged_in?, only: [:home]
    before_action :current_user
    before_action :company, only: [:home, :team_leader_home, :admin_home]
    skip_before_action :verify_authenticity_token

    def home
        @tasks = current_user.position.tasks unless current_user.position.nil?
        @team = current_user.team 
        @user = current_user
    end

    def team_leader_home
        @segments = current_user.team.segments unless current_user.team.nil?
        @team = current_user.team if current_user.position
        @user = current_user
        render layout: "team_leader_layout"
    end

    def admin_home
        @project = @company.projects.last
        render layout: "admin_layout"
    end

    # def notfound
    #     render file: "#{Rails.root}/public/404.html"
    # end

    private

    def login(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def company
        @company = current_user.company || current_user.user_company
    end

    def logged_in?
        !current_user ? redirect_to('/login') : !!current_user
    end

    def admin?
        redirect_to '/' if current_user.privilege == "Team Member"
        redirect_to team_leader_home_path if current_user.privilege == "Team Leader" 
    end

    def team_leader?
        redirect_to '/' if current_user.privilege == "Team Member"
    end

    def determine_leader_route(current_user)
        redirect_to "/admin/home" if current_user.privilege == "Admin"
        redirect_to "/team-leader/home" if current_user.privilege == "Team Leader"
    end
end
