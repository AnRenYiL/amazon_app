class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  def new
    @product = Product.new
    render :new
  end
  def create
    @product = Product.new product_params
    if @product.save
      flash[:notice] = "Product created successfully"
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    # @product = Product.find(params[:id])
    @review  = Review.new
    
    @reviews = @product.reviews.order(created_at: :desc)
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
end