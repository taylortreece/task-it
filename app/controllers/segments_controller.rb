class SegmentsController < ApplicationController

    def index
    end

    def new
        @segment = Segment.new
    end

    def create
        binding.pry
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def segment_params
        params.require(:segment).permit(:title, :deadline, :description, 
            :task_attributes => [
                :title,
                :deadline,
                :description
            ])
    end
end
