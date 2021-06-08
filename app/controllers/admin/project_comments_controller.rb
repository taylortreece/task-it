class Admin::ProjectCommentsController < ApplicationController
    before_action :current_user

    def index
    end

    def show
    end

    def new
    end

    def create
        @project = Project.find_by(id: params[:project_comment][:project_id])
        @project_comment = @project.project_comments.build(project_comment_params)
        if @project_comment.save
            redirect_to project_path(@project)
        else
            render 'project/show'
        end
    end

    def edit
    end
    
    def update
    end

    def destroy
        @project = ProjectComment.find_by(id: params[:id]).project
        ProjectComment.find_by(id: params[:id]).delete
        redirect_to project_path(@project)
    end

    private

    def project_comment_params
        params.require(:project_comment).permit(:content).with_defaults(user_id: current_user.id, project_id: @project.id)
    end
end
