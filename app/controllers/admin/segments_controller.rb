class Admin::SegmentsController < ApplicationController
    before_action :current_user, :company, :admin?
    layout "admin_layout"

    def index
    end

    def show
        @segment = Segment.find_by(id: params[:id])
        if params[:show_task_form]=="true"
            @task = @segment.tasks.build
        elsif params[:show_task_and_user_form] == "true"
            @task = @segment.tasks.build
            @user = @task.build_user
            @positon = @task.build_position
            @show_task_and_user_form = true
        else
        end
    end

    def new
        @segment = Segment.new
    end

    def create
        @segment = Segment.new(segment_params)
        @project = Project.find_by(id: params[:segment][:project_id])
        @team = Team.find_by(id: params[:segment][:team_id])
        if @segment.save
            redirect_to admin_project_path(@project)
        else
            render "admin/projects/show"
        end
    end

    def edit
        @segment = Segment.find_by(id: params[:id])
        @project = @segment.project
        @team = Team.new
    end

    def update
        @segment = Segment.find_by(id: params[:id])
        if @segment.update(segment_params)
            redirect_to admin_segment_path(@segment)
        else
            render :edit
        end
    end

    def destroy
        @segment = Segment.find_by(id: params[:id])
        @project = @segment.project
        @segment.destroy
        redirect_to admin_project_path(@project)
    end

    private

    def segment_params
        params.require(:segment).permit({:team_attributes => [:name, :description]}, 
        :title, :deadline, :description, :project_id, :user_id, :team_id, :completed)
        .with_defaults(user_id: current_user.id)
    end
end
