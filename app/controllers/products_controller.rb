class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize!, only: [:edit, :update, :destroy]
  def new
    @product = Product.new
    render :new
  end
  def create
    @product = Product.new product_params
    @product.user = current_user
    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    if params[:id]&&params[:product_id]
      @review = Review.find(params[:id])
    else
      @review = Review.new
    end
    
    @favourite = Favourite.find_by(product_id: @product, user_id: current_user)
    @reviews = @product.reviews.order(created_at: :desc)

    # @likes = @reviews.likes.find_by(user: current_user)
    
  end

  def index
    @products = Product.all
  end
  def edit
    
  end
  
  def update
    #for user to update the existing question, they must edit and then save it
    if @product.update product_params
      redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = "Product destroyed!"
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def find_product
    # this will get the current value inside of the db
    @product = Product.find(params[:id])
  end

  def authorize!
    redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @product)
  end
end
