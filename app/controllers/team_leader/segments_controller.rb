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
end
