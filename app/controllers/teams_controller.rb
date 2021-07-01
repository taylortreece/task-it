class TeamsController < ApplicationController
    before_action :current_user, :company

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
end