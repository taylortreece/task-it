class TasksController < ApplicationController

    def index
    end
    
    def new
        @task = @segment.tasks.build
    end

    def create
        @segment = Segment.find_by(id: params[:task][:segment_id])
        @task = @segment.tasks.build(task_params)
        binding.pry
        if @task.save
          binding.pry
            assign_user(@user)
            if @user.save then redirect_to segment_path(@segment) end
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

    def task_params
        params.require(:task).permit(:title, :deadline, :description, :segment_id,
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

    def assign_user(user)
        @task.assigned_user = user
        @task.position.assigned_user = user
    end

    def create_user(task)
        task.position.build_user(
            :first_name => params[:task][:user][:first_name],
            :last_name => params[:task][:user][:last_name],
            :email => params[:task][:user][:email],
            :password => params[:task][:user][:password],
            :password_confirmation => params[:task][:user][:password_confirmation],
            :privilege => params[:task][:user][:privilege],
        )
    end
end
