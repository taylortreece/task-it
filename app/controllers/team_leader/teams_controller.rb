class TeamLeader::TeamsController < ApplicationController
    before_action :current_user, :company, :team_leader?
    layout "team_leader_layout"

    def index
        @team_index_link = params[:team_index_link]
    end

    def show
        @team = Team.find_by(id: params[:id])
        @current_user = current_user
        if params[:show_user_form] == "true"
            @position = @team.positions.build
            @user = @position.build_user
        end
    end

    private

    def team_params
        params.require(:team).permit(:name, :description).with_defaults(user_id: current_user.id, company_id: current_user.company.id)
    end
end
