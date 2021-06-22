class TeamLeader::SegmentsController < ApplicationController
    before_action :current_user, :company, :team_leader?
    layout "team_leader_layout"

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

    def update
        @segment = Segment.find_by(id: params[:id])
        if @segment.update(segment_params)
            redirect_to team_leader_segment_path(@segment)
        else
            render :edit
        end
    end

    private

    def segment_params
        params.require(:segment).permit({:team_attributes => [:name, :description]}, 
        :title, :deadline, :description, :project_id, :user_id, :team_id, :completed)
        .with_defaults(user_id: current_user.id)
    end
end
