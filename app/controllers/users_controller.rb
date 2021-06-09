class UsersController < ApplicationController
    before_action :current_user
    before_action :company, only: [:index, :show, :edit, :update, :delete,]

    def index
    end

    def show
        @user = User.find_by(id: params[:id])
        @team = @user.team
    end

    def profile
        @company = current_user.company
        @user=(User.find_by(id: params[:id])) if params[:id]
        @current_user = current_user
        if !params[:show_form].nil? && params[:edit] == "edit"
            @edit_my_profile = true
            @position = @user.positions.build
            @team = @position.build_team
            @show_form = params[:show_form]
        elsif params[:edit] == "edit"
            @edit_my_profile = true
            @position = @user.positions.build
            @team = @position.build_team
        else
            @edit_my_profile = false
        end
    end

    def profile_form_handler
        @user = User.find_by(id: params[:id])
        @user.update(created_user_params)
        redirect_to "/profile/#{@user.id}"
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
            @team = @user.team
            redirect_to team_user_path(@team, @user)
        else
            @position = @user.assigned_position
            if @user.id == current_user.id
                @edit_my_profile = "true"
                render :profile
            else
            render "/teams/1?show_user_form=true"
            end
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
                :team_id,
            ]
        )
    end

    def created_user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :privilege,
            :team_attributes => [
                :name,
                :description,
                :id,
                :profile #for determining if the form came from the profile page. Do not allow into update or create method for team
            ],
            position_attributes: [
                :title,
                :description,
                :team_id,
            ],
        ).with_defaults(user_id: current_user.id)
    end
end