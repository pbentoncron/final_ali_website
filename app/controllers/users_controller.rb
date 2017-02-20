class UsersController < ApplicationController
    def index
    end

    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to root_path
        else
            flash[:errors] = user.errors.full_messages
            redirect_to users_path
        end
    end

    def home
        @reviews = Review.where(approved: true).limit(3).order("RANDOM()")
    end

    def about
    end

    def services
    end

    def portfolio
    end

    def show
        if !current_user
            redirect_to root_path
        else
            @user = current_user
        end
    end

    def update
        if current_user.update(user_params)
            redirect_to user_path
        else
            flash[:errors] = ["Something went wrong, please try again!"]
            redirect_to :back
        end
    end

    def edit
        if !current_user
            redirect_to root_path
        else
            @user = current_user
        end
    end

    def admin?
      current_user.admin == true
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
        end
end
