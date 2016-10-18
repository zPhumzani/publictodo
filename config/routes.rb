Rails.application.routes.draw do

  resources :tasks do 
    member do
      put :change
    end
  end
  devise_for :users
  resources :users
  get 'about' => 'pages#about', as: :about
  # root path
  root 'pages#home'
end
