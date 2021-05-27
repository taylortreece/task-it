class TaskCommentsController < ApplicationController

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
            redirect_to task_path(@task)
        else
            render 'tasks/show'
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def task_comment_params
        params.require(:task_comment).permit(:content).with_defaults(user_id: current_user.id, task_id: @task.id)
    end
end
