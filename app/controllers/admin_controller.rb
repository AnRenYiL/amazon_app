class AdminController < ApplicationController

    def panel
        if current_user.is_admin == true
        @product_count = Product.all.count
        @review_count = Review.all.count
        @user_count = User.all.count
        render :panel
        else
        redirect_to root_path
        end
    end
end
