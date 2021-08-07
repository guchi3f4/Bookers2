Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/home/about" => "abouts#top"
  resources :users, only: [:edit, :update, :index, :show]
  resources :books, only: [:create,:edit, :update, :index, :show, :destroy] do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

end
