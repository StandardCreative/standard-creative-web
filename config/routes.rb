Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, :skip => [:registrations]

  root "home#index"

end
