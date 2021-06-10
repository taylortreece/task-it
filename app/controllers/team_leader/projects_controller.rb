class TeamLeader::ProjectsController < ApplicationController
    before_action :current_user, :company, :team_leader?
    layout "team_leader_layout"
    
    def index
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

    def new
        @project = current_user.projects.build
    end

    def create
        @project = current_user.projects.build(project_params)
        @project.company = current_user.company

        if @project.save
            redirect_to team_leader_project_path(@project)
        else
            render :new
        end
    end

    def edit
        @project = Project.find_by(id: params[:id])
    end

    def update
        binding.pry
        @project = Project.find_by(id: params[:id])
        if @project.update(project_params)
        binding.pry
        redirect_to team_leader_project_path(@project)
        else
        binding.pry
        render :edit
        end
    end

    def destroy
        Project.find_by(id: params[:id]).destroy
        redirect_to team_leader_projects_path
    end

    private

    def project_params
    params.require(:project).permit(:title, :deadline, :description, :completed, company: current_user.company,
        :segment_attributes => [
            :title,
            :deadline,
            :description
        ]
    )
    end

end
