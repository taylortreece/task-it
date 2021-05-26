class UsersController < ApplicationController

    def index
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        binding.pry

        if @user.save
            login(@user)
            redirect_to '/'
        else
            flash[:error] = "Oops! Something went wrong. Try again."
            render :new
        end
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

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :privilege,

            company_attributes: [
                :name,
                :industry,
                :address,
                :city,
                :state,
                :phone_number,
                :email
        ],
    
            position_attributes: [
                :title,
                :description
            ]
        )
    end

end
