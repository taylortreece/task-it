class UsersController < ApplicationController
    before_action :current_user, only: [:index, :show, :edit, :update, :delete,] 
    before_action :company, only: [:show]

    def index
    end

    def show
        @user = User.find_by(id: params[:id])
        @team = @user.positions.last.team
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
            @position = @user.positions.find_by(team_id: params[:user][:position_attributes][:team_id])
            if @user.save
                @user = User.new
                render 'teams/show'
            else
                render "/teams/1?show_user_form=true"
            end
        end
    end

    # def create_new_team_member
    #     @user = User.new(created_user_params)
    #     @team = Team.find_by(id: params[:user][:position_attributes][:team_id])
    #     @position = @user.positions.last
    #     if @user.save
    #         @user = User.new
    #         render 'teams/show'
    #     else
    #         render "/teams/1?show_user_form=true"
    #     end
    # end

    def edit
        @team = Team.find_by(id: params[:team_id])
        @user = User.find_by(id: params[:id])
        @position = @user.positions.find_by(team_id: params[:team_id])
    end

    def update
        @team = Team.find_by(params[:team_id])
        @user = User.find_by(params[:id])
        if @user.update(created_user_params)
            redirect_to team_user_path(@team, @user)
        else
            @position = @user.positions.last
            render :edit
        end
    end

    def destroy
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
        ).with_defaults(user_id: current_user.id, company: current_user.company)
    end
end
