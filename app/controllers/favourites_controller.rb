class FavouritesController < ApplicationController
    def create
        @product = Product.find(params[:product_id])
        favourite = Favourite.new(is_favourite: params[:is_favourite], user:current_user, product: @product)
        if !can?(:favourite, @product)
            redirect_to product_path(@product), alert: "can't favourite your own product"
        elsif favourite.save
          flash[:success] = "Product Favourited"
          redirect_to product_path(@product)
        else
          flash[:danger] = favourite.errors.full_messages.join(", ")
          redirect_to product_path(@product)
        end
    end
    
    def destroy
        favourite = current_user.favourites.find(params[:id])
        @product = favourite.product
        if can? :destroy, favourite
            favourite.destroy
            flash[:success] = "Canceled"
            redirect_to product_path(@product)
        else
            flash[:danger] = "Can't canceled"
            redirect_to product_path(@product)
        end
    end
    
end
