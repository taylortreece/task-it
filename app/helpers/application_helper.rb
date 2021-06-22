module ApplicationHelper
    # def display_teams
    #     if @current_user.teams.present?
    #     @current_user.teams.each do |team|
    #         link_to "#{team.name}", team_path(team)<br><br>
    #         end
    #     else
    #         "#{@current_user.company.name} does not have any registered teams."
    #     end
    # end

    def display_progress(arg)
        if arg.completed
            "completed"
        else
            "incomplete"
        end
    end
end
