class ProjectsController < ApplicationController
    
    def index
        @projects = current_user.projects.all
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
            redirect_to @project
        else
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def project_params
    params.require(:project).permit(:title, :deadline, :description, company: current_user.company,
        :segment_attributes => [
            :title,
            :deadline,
            :description
        ]
    )
    end

end
