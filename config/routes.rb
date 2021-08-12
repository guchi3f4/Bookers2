Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/home/about" => "homes#about"

  resources :users, only: [:edit, :update, :index, :show] do
    resource :relationships, only: [:create, :destroy]
    member do
      get :following, :followers
    end
  end

  resources :books, only: [:create,:edit, :update, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :rooms, only: [:create, :show]
  resources :messages, only: [:create]

 get '/search' => 'searches#search'
end
