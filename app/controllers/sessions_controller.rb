class SessionsController < ApplicationController
    layout "login", only: [:login]
    #before_action :current_user

    def login
    end

    def create
        if auth
             user = User.find_or_create_by(email: auth[:info][:email]) do |user|
             user.password = SecureRandom.hex(12)
            end
            if user
                session[:user_id] = user.id
                @current_user = user
                determine_route(@current_user)
            else
                render :login
            end  
        else
            user = User.find_by(email: params[:user][:email])
            if user && user.authenticate(params[:user][:password])
                session[:user_id] = user.id
                @current_user = user
                determine_route(@current_user)
            else
                redirect_to :login
            end
        end
    end

    def logout
        session.clear
        redirect_to '/login'
    end

    private

    def determine_route(current_user)
        redirect_to "/admin/home" if current_user.privilege == "Admin"
        redirect_to "/" if current_user.privilege == "Team Member"
        redirect_to "/team-leader/home" if current_user.privilege == "Team Leader"
    end

    def auth
        request.env["omniauth.auth"]
    end
        
end
