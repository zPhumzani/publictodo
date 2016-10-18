Rails.application.routes.draw do

  devise_for :users
  resources :users
  get 'about' => 'pages#about', as: :about
  # root path
  root 'pages#home'
end
