Rails.application.routes.draw do
  resources :projects
  resources :things, only: [:create, :destroy]

  get 'home/index'

  devise_for :users, :skip => [:registrations]

  root "home#index"

end
