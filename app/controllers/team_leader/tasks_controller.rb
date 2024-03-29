class TeamLeader::TasksController < ApplicationController
    before_action :current_user, :company, :team_leader?
    layout "team_leader_layout"
    
    def index
    end
    
    def new
        @task = @segment.tasks.build
    end

    def create
        @segment = Segment.find_by(id: params[:task][:segment_id])
        @task = @segment.tasks.build(task_params)
        assign_existing_user
        if @task.save
            redirect_to admin_segment_path(@segment)
        else
            render 'admin/segments/show'
        end
    end

    def show
        @task = Task.find_by(id: params[:id])
        @segment = @task.segment
    end

    def edit
        @task = Task.find_by(id: params[:id])
        @segment = @task.segment
        @task.assigned_user.nil? ? @user=(User.new) : @user=(@task.assigned_user)
        @user.assigned_position.nil? ? @position=(Position.new) : @position=(@user.assigned_position)
        if params[:show_user_form]
            @show_user_form = params[:show_user_form]
        end
    end

    def update
        @task = Task.find_by(id: params[:id])
        if @task.update(task_params)
            redirect_to team_leader_segment_task_path(@task)
        else
            render :edit
        end
    end

    def destroy
        @task = Task.find_by(id: params[:id])
        @segment = @task.segment
        @task.destroy
        redirect_to admin_segment_path(@segment)
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

    def assign_existing_user
        if @task.position.assigned_user_id.nil?
            @task.position.assigned_user_id = @task.assigned_user.id
        elsif @task.assigned_user_id.nil?
            @task.assigned_user_id = @task.position.assigned_user.id
        else
        end
    end
end