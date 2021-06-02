class TeamsController < ApplicationController
    before_action :current_user, :company

    def index
    end

    def show
        @team = Team.find_by(id: params[:id])
        if params[:show_user_form] == "true"
            @position = @team.positions.build
            @user = @position.build_user
        end
    end

    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        if @team.save
            redirect_to @team
        else
            render :new
        end
    end

    def edit
        @team = Team.find_by(id: params[:id])
    end

    def update
        @team = Team.find_by(id: params[:id])
        if @team.update(team_params)
            redirect_to @team
        else
            render :edit
        end
    end

    def destroy
    end

    private

    def team_params
        params.require(:team).permit(:name, :description).with_defaults(user_id: current_user.id, company_id: current_user.company.id)
    end
end
