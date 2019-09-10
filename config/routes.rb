Rails.application.routes.draw do
  
  root to:'welcome#index'
  get 'bill_splitter/splitter'
  post 'bill_splitter/splitter'
  get 'welcome/index'
  get 'entry/home'
  get 'entry/about'
  get 'entry/contact_us'
  get 'entry/show_success'
  post 'entry/show_success'
  get 'entry/hello'

  # get '/products/new', {to: "products#new", as: :new_product}
  # post 'products', {to: 'products#create', as: :products}
  # get '/products', {to: 'products#index'}
  # get '/products/:id', {to: "products#show", as: :product}
  # get '/products/:id/edit', {to: "products#edit", as: :edit_product}
  # patch '/products/:id', {to: "products#update"}
  # delete '/products/:id', {to: "products#destroy"}
  resources :products do
    resources :reviews, only: [:create, :destroy]
  end
  resources :projects do
    resources :tasks, only: [:create, :destroy]
    resources :discussions do
      resources :comments
    end
  end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  # resources :entry
  # post 'entry/contact_us'
  # root to:'enterpage#about'
  #  resources :questions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
