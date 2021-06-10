class SegmentsController < ApplicationController
    before_action :current_user, :company

    def index
    end

    def show
        @segment = Segment.find_by(id: params[:id])
    end
end