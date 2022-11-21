Rails.application.routes.draw do
  devise_for :users
  root 'top#index'
  # get 'list/new'
  # post 'list/create'
  resources :list, only: %i(new create edit update destroy)do
      resources :card, except: %i(index)
  end

  get 'list/edit_user_name'
  post 'list/update_user_name'
end
