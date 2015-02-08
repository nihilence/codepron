CodePron::Application.routes.draw do

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :previews, only: [:create, :show, :index, :update]
    resources :users, only: :show
  end

  resources :htmldocs, only: :show
  resources :users, only: [:new, :create]
  resource :session, only:[:create, :destroy, :new]

end
