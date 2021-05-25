class ApplicationController < ActionController::Base
    before_action :logged_in?, only: [:home]

    def home
        @current_user = current_user
    end

    private

    def login(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user = User.find_by(id: session[:user_id])
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
