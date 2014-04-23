Rails.application.routes.draw do
  devise_for :users, :skip => [:registrations]

  # **************************************************************************** #
  #  all routes must be defined above this line to avoid conflicts with :things  #
  # **************************************************************************** #

  resources :things, path: ''

  get 'home/index'
  root "home#index"
end
