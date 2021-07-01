class TeamLeader::ProjectsController < ApplicationController
    before_action :current_user, :company, :team_leader?
    layout "team_leader_layout"
    
    def index
        @project_index_links = params[:project_index_link]
        @projects = company.projects.ordered
    end

    def show
        @project = Project.find_by(id: params[:id])

        if params[:show_segment_form] == "true"
            @segment = Segment.new
        elsif params[:show_segment_and_team_form] == "true"
            @segment = Segment.new
            @team = @segment.build_team
        else
        end
    end
end
