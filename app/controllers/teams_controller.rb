class TeamsController < ApplicationController
    

    def index
    end

    def show
        @team = Team.find_by(id: params[:id])
        if params[:show_user_form] == "true"
            @position = @team.positions.build
            @user = @position.build_user
        end
    end

    def new
        @team = Team.new
    end

    def create
        binding.pry
        @team = Team.new(team_params)
        if @team.save
            binding.pry
            redirect_to @team
        else
            binding.pry
            render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def team_params
        params.require(:team).permit(:name, :description).with_defaults(user_id: current_user.id, company_id: current_user.company.id)
    end
end
