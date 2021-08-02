Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  resources :users, only: [:edit, :update, :index, :show]
  resources :books
end
