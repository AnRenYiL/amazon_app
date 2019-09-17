class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_review, except: [:create]
    before_action :find_product
    before_action :authorize!, except: [:create]
    def create
        @review = Review.new review_params
        @review.product = @product
        @review.user = current_user
        if @review.save
            redirect_to product_path(@product)
        else
        @reviews = @product.reviews.order(created_at: :desc)
        render 'products/show'
        end    
    end
    def destroy
        @review.destroy
        redirect_to product_path(@product), notice: 'Review Deleted'
    end
    def show
        @reviews = @product.reviews
        render 'products/show'
    end
    def edit
        
    end
    def update
        if @review.update review_params
            redirect_to product_path(@product), notice: 'Review Updated'
        else
          render :edit
        end
    end
    private

    def review_params
        params.require(:review).permit(:body, :rating)
    end

    def find_review
        @review = Review.find(params[:id])
    end

    def find_product
        @product = Product.find(params[:product_id])
    end

    def authorize!
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @review)
    end
end
