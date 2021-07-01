class TasksController < ApplicationController
    before_action :current_user, :company

    def index
    end

    def show
        @task = Task.find_by(id: params[:id])
        @segment = @task.segment
    end

    def edit
        @task = Task.find_by(id: params[:id])
    end

    def update
        @task = Task.find_by(id: params[:id])
        if @task.update(task_params)
            redirect_to segment_task_path(@task)
        else
            render :show
        end
    end

    private

    def task_params
        params.require(:task).permit(:title, :deadline, :description, :segment_id, :position_id, :completed,
        user_attributes: [
            :first_name,
            :last_name,
            :email,
            :password,
            :password_confirmation,
            :privilege,
            :user_param_value
        ],
        position_attributes: [
            :title,
            :description,
            :user_id
        ]).with_defaults(user_id: current_user.id)
    end
end