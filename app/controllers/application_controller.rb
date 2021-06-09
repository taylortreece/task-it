class ApplicationController < ActionController::Base
    before_action :logged_in?, only: [:home]
    before_action :current_user
    skip_before_action :verify_authenticity_token
    layout "admin_layout", only: [:admin_home]
    layout "team_leader_layout", only: [:team_leader_home]

    def home
        @tasks = current_user.position.tasks
        @user = current_user
        redirect_to admin_home_path if @user.privilege == "checked Admin" || @user.privilege == "Admin"
        redirect_to team_leader_home_path if @user.privilege == "checked Team Leader" || @user.privilege == "Team Leader"
    end

    def team_leader_home
        @segments = true 
    end

    def admin_home
        @project = Project.all.last
    end

    def notfound
        render file: "#{Rails.root}/public/404.html"
    end

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

    def validation_status
        if current_user.admin
            @admin = true
        elsif
            current_user.team_leader
            @team_leader = true
        elsif
            current_user.team_member
            @team_member = true
        else
            redirect_to '/login'
        end
    end
end
