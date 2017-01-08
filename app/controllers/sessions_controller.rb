class SessionsController < ApplicationController
    def create
      user = User.find_by(email: user_params[:email])
      if user && user.authenticate(user_params[:password])
          session[:user_id] = user.id
          redirect_to root_path(session[:user_id])
      else
          flash[:errors] = ["Invalid Credentials"]
          redirect_to sessions_path
      end
    end

    def require_admin
      if !current_user || !current_user.admin?
        redirect_to root_path
      else
        @reviews = Review.all.order(created_at: :desc)
        render 'admin'
      end 
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_path
    end

    private
      def user_params
          params.require(:user).permit(:email, :password)
      end
end
