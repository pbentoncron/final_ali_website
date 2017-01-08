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
        @reviews = Review.where(approved: true).last(3)
    end

    def about
    end

    def services
    end

    def portfolio
    end

    def admin?
      current_user.admin == true
    end

    private
        def user_params
            params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
        end
end
