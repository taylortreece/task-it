class TasksController < ApplicationController

    def index
    end
    
    def new
        @task = @segment.tasks.build
    end

    def create
        @segment = Segment.find_by(id: params[:task][:segment_id])
        @task = @segment.tasks.build(task_params)
        assign_position_to @task
        if @task.save
            redirect_to segment_path(@segment)
        else
            render 'segments/show'
        end
    end

    def show
        @task = Task.find_by(id: params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    # changed params to accept assigned_user_id instead of user_id

    def task_params
        params.require(:task).permit(:title, :deadline, :description, :segment_id, :position_id,
        user_attributes: [
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :privilege
        ],
        position_attributes: [
            :title,
            :description,
            :user_id
        ]).with_defaults(user_id: current_user.id)
    end

    def assign_position_to(task)
        task.assigned_user = task.position.assigned_user
    end

end
