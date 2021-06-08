class Admin::TaskCommentsController < ApplicationController
    before_action :current_user
    layout "admin_layout"

    def index
    end

    def show
    end

    def new
    end

    def create
        @task = Task.find_by(id: params[:task_comment][:task_id])
        @task_comment = @task.task_comments.build(task_comment_params)
        if @task_comment.save
            redirect_to segment_task_path(@task.segment, @task)
        else
            render 'tasks/show'
        end
    end

    def edit
    end

    def update
    end

    def destroy
        @task = TaskComment.find_by(id: params[:id]).task
        TaskComment.find_by(id: params[:id]).delete
        redirect_to segment_task_path(@task.segment, @task)
    end

    private

    def task_comment_params
        params.require(:task_comment).permit(:content).with_defaults(user_id: current_user.id, task_id: @task.id)
    end
end