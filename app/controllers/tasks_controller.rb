class TasksController < ApplicationController

    def index
    end
    
    def new
        @task = @segment.tasks.build
    end

    def create
        @segment = Segment.find_by(id: params[:task][:segment_id])
        @task = @segment.tasks.build(task_params)
        @task.user = current_user
        @position = @task.build_position(title: params[:task][:user][:position][:title], description: params[:task][:user][:position][:description], team: @task.segment.team)
        @position.user = current_user
        @task.position = @position
        binding.pry
        if @task.save && @position.save
            @user = @task.position.build_user(
                :first_name => params[:task][:user][:first_name],
                :last_name => params[:task][:user][:last_name],
                :email => params[:task][:user][:email],
                :password => params[:task][:user][:password],
                :password_confirmation => params[:task][:user][:password_confirmation],
                :privilege => params[:task][:user][:privilege],
            )
            @task.assigned_user = @user
            @position.assigned_user = @user
            binding.pry
            if @user.save
            binding.pry
                redirect_to segment_path(@segment)
            end
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
        params.require(:task).permit(:title, :deadline, :description)
    end

    def create_user
        @user = User.new(
            :first_name => params
        )
    end
end
