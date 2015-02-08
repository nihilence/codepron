CodePron::Application.routes.draw do

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :previews, only: [:create, :show, :index, :update]
  end

  resources :htmldocs, only: :show
  resources :users, only: [:new, :create, :show]
  resource :session, only:[:create, :destroy, :new]

end
