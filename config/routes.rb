Rails.application.routes.draw do
  resources :things

  get 'home/index'

  devise_for :users, :skip => [:registrations]

  root "home#index"

end
