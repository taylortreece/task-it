class TasksController < ApplicationController

    def index
    end
    
    def new
        @task = @segment.tasks.build
    end

    def create
        @segment = Segment.find_by(id: params[:segment_id])
        @task = @segment.tasks.build(task_params)
        @task.user = current_user
        binding.pry
        if @task.save
            redirect_to segment_path(@segment)
        else
            render 'segment/show'
        end
    end

    def show
        @task = Task.find_by(id: oarams[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def task_params
        params.require(:tasks).permit(:title, :deadline, :description)
    end
end
