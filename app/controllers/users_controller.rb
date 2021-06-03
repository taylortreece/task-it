class UsersController < ApplicationController
    before_action :current_user, only: [:index, :show, :edit, :update, :delete,] 
    before_action :company, only: [:show]

    def index
    end

    def show
        @user = User.find_by(id: params[:id])
        @team = @user.team
    end

    def new
        @user = User.new
        render layout: false
    end

    def create
        #create a new user from signup
        if !current_user
            @user = User.new(signup_user_params)
            if @user.save
                login(@user)
                redirect_to '/'
            else
                flash[:error] = "Oops! Something went wrong. Try again."
                render :new
            end
        #create a new user as an admin
        else
            @user = User.new(created_user_params)
            @team = Team.find_by(id: params[:user][:position_attributes][:team_id])
            @position = @user.assigned_position
            if @user.save
                redirect_to @team
            else
                render "teams/show"
            end
        end
    end

    def edit
        @team = Team.find_by(id: params[:team_id])
        @user = User.find_by(id: params[:id])
        @position = @user.assigned_position
    end

    def update
        @team = Team.find_by(id: params[:user][:position_attributes][:team_id])
        @user = User.find_by(id: params[:id])
        
        if @user.update(created_user_params)
            redirect_to team_user_path(@team, @user)
        else
            @position = @user.assigned_position
            render "/teams/1?show_user_form=true"
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.position.delete && @user.delete
        redirect_to '/'
    end

    private

    def signup_user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :privilege,

            company_attributes: [
                :name,
                :industry,
                :address,
                :city,
                :state,
                :phone_number,
                :email
            ],
            position_attributes: [
                :title,
                :description,
                :team_id
            ]
        )
    end

    def created_user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :privilege,
            position_attributes: [
                :title,
                :description,
                :team_id
            ]
        ).with_defaults(user_id: current_user.id)
    end
end
