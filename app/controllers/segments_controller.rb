class SegmentsController < ApplicationController
    before_action :current_user

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
        if @team then @segment.update(team: @team, user: current_user) end
        if @segment.save
            redirect_to project_path(@project)
        else
            render "projects/show"
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def segment_params
        params.require(:segment).permit({:team_attributes => [:name, :description]}, 
        :title, :deadline, :description, :project_id, :user_id, :team_id)
        .with_defaults(user_id: current_user.id)
    end

    # def find_team(arg)
    #     arg.nil? ? return(nil) : @team=(Team.find_by(arg))
    # end
end
