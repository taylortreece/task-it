class SessionsController < ApplicationController
    layout "login"
    #before_action :current_user

    def login
    end

    def create
        @user = User.find_by(email: params[:user][:email])
        if @user && @user.authenticate(params[:user][:password])
            session[:user_id] = @user.id
            @current_user = @user
            redirect_to '/'
        else
            render :login
        end
    end

    def logout
        session.clear
        redirect_to '/login'
    end

    private
end
