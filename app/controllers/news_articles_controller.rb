class NewsArticlesController < ApplicationController
    before_action :find_news_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, only: [:new, :create, :destroy, :edit]
    def new
        @news_article = Newsarticle.new
    end

    def create
      @news_article = Newsarticle.new news_article_params
      @news_article.user = current_user
      if @news_article.save
        redirect_to news_article_path(@news_article)
      else
        render :new
      end
    end
    
    def show
        
    end

    def destroy
        @news_article.destroy
        flash[:danger] = "News Article destroyed!"
        redirect_to news_articles_path
    end

    def index
        @news_articles = Newsarticle.order(created_at: :asc)
    end
    
    def edit
        
    end

    private

    def news_article_params
      params.require(:news_article).permit(:title, :description, :published_at, :view_count)
    end

    def find_news_article
        @news_article = Newsarticle.find(params[:id])
    end
    
end
