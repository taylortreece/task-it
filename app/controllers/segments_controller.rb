class SegmentsController < ApplicationController
    before_action :current_user, :company

    def index
    end

    def show
        @segment = Segment.find_by(id: params[:id])
    end

    def destroy
        Segment.find_by(id: params[:id]).destroy
        redirect_to '/'
    end
end