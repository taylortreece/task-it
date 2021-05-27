class SegmentCommentsController < ApplicationController

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
            redirect_to segment_path(@segment)
        else
            render 'segments/show'
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def segment_comment_params
        params.require(:segment_comment).permit(:content).with_defaults(user_id: current_user.id, segment_id: @segment.id)
    end
end
