class SegmentsController < ApplicationController

    def index
    end

    def new
        @segment = Segment.new
    end

    def create
        @segment = Segment.new(segment_params)
        @project = Project.find_by(id: params[:segment][:project_id])
        params[:segment][:team_id] ? @team=(Team.find_by(id: params[:segment][:team_id])) : @team=(@segment.build_team(name: params[:segment][:team][:name], description: params[:segment][:team][:description], user: current_user, company: current_user.company))

        if @team.save
            @segment.update(team: @team, user: current_user)
           if @segment.save
               redirect_to project_path(@project)
           else
           render "projects/show"
           end
        end
    end

    def show
        @segment = Segment.find_by(id: params[:id])

        if params[:show_task_form]=="true"
            @task = @segment.tasks.build
            binding.pry
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
        params.require(:segment).permit(:title, :deadline, :description, :project_id, :user_id => current_user,
            :task_attributes => [
                :title,
                :deadline,
                :description
            ])
    end
end
