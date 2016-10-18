Rails.application.routes.draw do

  get 'about' => 'pages#about', as: :about
  # root path
  root 'pages#home'
end
