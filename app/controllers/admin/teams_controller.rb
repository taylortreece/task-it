class Admin::TeamsController < ApplicationController
    before_action :current_user, :company, :admin?
    layout "admin_layout"

    def index
        @team_index_link = params[:team_index_link]
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
            redirect_to admin_team_path(@team)
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
            redirect_to admin_team_path(@team)
        else
            render :edit
        end
    end

    def destroy
        @team = Team.find_by(id: params[:id])

        if @team.positions.empty? && @team.segments.empty?
            @team.delete
            redirect_to admin_teams_path
        else
            flash[:message] = "A Team cannot be deleted while it has members or segments! Relocate or delete all members and segments in order to delete #{@team.name}."
            render :show
        end
    end

    private

    def team_params
        params.require(:team).permit(:name, :description).with_defaults(user_id: current_user.id, company_id: current_user.company.id)
    end
end
