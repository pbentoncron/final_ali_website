class ReviewsController < ApplicationController
    def index
      if !current_user
        flash[:errors] = ["Must be registered and logged in to leave a review!"]
        redirect_to root_path
      else
        @reviews = Review.where(approved: true).last(3)
      end
    end

    def create
      review = current_user.reviews.new(review_params)
      if review.save
          flash[:message] = ["Thank you! Your review will be displayed after Approval from admin."]
          redirect_to root_path
      else
          flash[:errors] = review.errors.full_messages
          redirect_to :back
      end
    end

    def edit
      if !current_user
          redirect_to root_path
      else
          @user = current_user
          @review = Review.find(params[:id])
      end
    end

    def testimonials
      @reviews = Review.all.order(created_at: :desc).page(params[:page]).per(5)
    end

    def update
      review = Review.find(params[:id])

      if review.update(approved: true)
          redirect_to admin_path
      else
          flash[:errors] = ["Something went wrong!"]
          redirect_to admin_path
      end
    end

    def update_two
      @review = Review.find(params[:id])
      if @review.update(review_params)
        redirect_to testimonials_path
      else
        flash[:errors] = ["Something went wrong!"]
        redirect_to edit_review_path
      end
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      if current_user.admin == true
        redirect_to admin_path
      else
        redirect_to testimonials_path
      end
    end

    private

        def review_params
            params.require(:review).permit(:content, :approved, :user_id)
        end
end
