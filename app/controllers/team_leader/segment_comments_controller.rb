class TeamLeader::SegmentCommentsController < ApplicationController
    before_action :current_user
    layout "team_leader_layout"

    def index
    end

    def show
    end

    def new
    end

    def create
        @segment = Segment.find_by(id: params[:segment_comment][:segment_id])
        @segment_comment = @segment.segment_comments.build(segment_comment_params)
        if @segment_comment.save
            redirect_to team_leader_segment_path(@segment)
        else
            render 'team_leader/segments/show'
        end
    end

    def edit
    end

    def update
    end

    def destroy
        @segment = SegmentComment.find_by(id: params[:id]).segment
        SegmentComment.find_by(id: params[:id]).delete
        redirect_to team_leader_segment_path(@segment)
    end

    private

    def segment_comment_params
        params.require(:segment_comment).permit(:content).with_defaults(user_id: current_user.id, segment_id: @segment.id)
    end
end
