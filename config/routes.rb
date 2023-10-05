Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
  get "/users" , to: "users#index",  as: "users"
  get "/users/:id" , to: "users#show" , as: 'user'
  get "/users/:id/posts" , to: "posts#index", as: "user_posts"
  get "/users/:id/posts/:id" , to: "posts#show", as: "user_post"
  get "/users/:id/posts/new" , to: "posts#new"
  # resources :users, only: [:index, :show] do
  #   resources :posts, only: [:index, :show, :new, :create] do
  #     resources :comments, only: [:new, :create]
  #     resources :likes, only: [:create]
  #   end
  # end
  resources :users do
    resources :posts do
      resources :comments
    end
  end
end