require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end
    describe '#new' do
      context 'with signed in user' do
        before do
          session[:user_id] = current_user.id
        end
        it "renders a new template" do
          get(:new)
          expect(response).to(render_template(:new))
        end
        it "sets an instance variable with a new news article" do
          get(:new)
          expect(assigns(:news_article)).to(be_a_new(Newsarticle))
        end
      end
      context 'without signed in user' do
        it 'redirects the user to session new' do
          get(:new)
          expect(response).to redirect_to(new_session_path)
        end
        it 'sets a danger flash message' do
          get(:new)
          expect(flash[:danger]).to be
        end
      end
    end

    describe "#create" do
      def valid_request
        post(:create, params: {news_article: FactoryBot.attributes_for(:newsarticle)})
      end
      context 'without signed in user' do
        it 'redirects to the new session page' do
          valid_request
          expect(response).to redirect_to(new_session_path)
        end
      end
      context 'with signed in user' do
        before do
          session[:user_id] = current_user.id
        end
        context "with valid parameters" do
          it 'saves a new news article to the db' do
            count_before = Newsarticle.count
            valid_request
            count_after = Newsarticle.count
            expect(count_after).to eq(count_before + 1)
          end
          it 'redirects to the show page of that news article' do
            valid_request
            news_article = Newsarticle.last
            expect(response).to(redirect_to(news_article_path(news_article.id)))
          end
        end
    
        context "with invalid parameters" do
          def invalid_request
            post(:create, params: {news_article: FactoryBot.attributes_for(:newsarticle, title: nil)})
          end
          it 'does not create a news article in the db' do
            count_before = Newsarticle.count
            invalid_request
            count_after = Newsarticle.count
            expect(count_after).to eq(count_before)
          end
          it 'renders the new template' do
            invalid_request
            expect(response).to render_template(:new)
          end
    
          it 'assigns an invalid news article as an instance variable' do
            invalid_request
            expect(assigns(:news_article)).to be_a(Newsarticle)
            # expect(assigns(:job_post).valid?).to be false
          end
        end
      end
    end

    describe "#show" do
      it "renders the show template" do
        news_article = FactoryBot.create(:newsarticle)
        get(:show, params: {id: news_article.id })
        expect(response).to render_template :show
      end
    
      it "sets @news_article for the shown object" do
          news_article = FactoryBot.create(:newsarticle)
        get(:show, params: {id: news_article.id })
        expect(assigns(:news_article)).to eq(news_article)
      end
    end

    describe "#destroy" do
      context 'without user signed in' do
        it 'redirects to the new session page' do
          news_article = FactoryBot.create(:newsarticle)
          delete(:destroy, params: {id: news_article.id})
          expect(response).to redirect_to(new_session_path)
        end
      end

      context 'with user signed in' do
        before do
          session[:user_id] = current_user.id
        end
        it 'removes the news article from the db' do
          news_article = FactoryBot.create(:newsarticle)
          delete(:destroy, params: {id: news_article.id})
          expect(Newsarticle.find_by(id: news_article.id)).to(be(nil))
        end
      
        it 'redirects to the job posts index' do
          news_article = FactoryBot.create(:newsarticle)
          delete(:destroy, params: {id: news_article.id})
          expect(response).to redirect_to(news_articles_url)
        end
      
        it 'sets a flash message' do
          news_article = FactoryBot.create(:newsarticle)
          delete(:destroy, params: {id: news_article.id})
          expect(flash[:danger]).to be
        end
      end
    end

    describe "#index" do
        it 'renders the index template' do
          get :index
          expect(response).to render_template(:index)
        end
    
        it 'assigns an instance variable to all created news articles' do
          get :index
          news_article_1 = FactoryBot.create(:newsarticle)
          news_article_2 = FactoryBot.create(:newsarticle)
          expect(assigns(:news_articles)).to eq([news_article_2, news_article_1])
        end
    end

    
    describe "#edit" do
      news_article = FactoryBot.create(:newsarticle)
      context "without user signed in" do
        it "redirects to the sign in page" do
          get :edit, params: { id: news_article.id }
          expect(response).to redirect_to new_session_path
        end
      end
      context "with user signed in" do
        before do
          session[:user_id] = current_user.id
        end
        it 'renders the edit template' do
            get(:edit, params: {id: news_article.id })
            expect(response).to render_template :edit
        end
        it "sets @news_article for the shown object" do
            get(:edit, params: {id: news_article.id })
            expect(assigns(:news_article)).to eq(news_article)
        end
      end
    end

    describe "#update" do
      context "without user signed in" do
        
      end
      context "with user signed in" do
      end
    end
    
end
