Rails.application.routes.draw do
  resources :projects

  get 'home/index'

  devise_for :users, :skip => [:registrations]

  root "home#index"

end
