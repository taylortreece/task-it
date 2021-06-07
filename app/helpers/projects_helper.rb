module ProjectsHelper
    def pretty_deadline(arg)
        arg.deadline.strftime("Deadline: %m/%d/%Y")
    end

    def completed(arg)
        if arg.completed
            "This #{arg.class} has been completed."
        else
            "This #{arg.class} is incomplete."
        end
    end
end