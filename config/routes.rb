CodePron::Application.routes.draw do

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :previews, only: [:create, :show, :index, :update] do
      resources :comments, only: [:index, :destroy]
    end
    resources :comments, only:[:create, :show]

  end

  resources :htmldocs, only: :show
  resources :users, only: [:new, :create, :show, :index]
  resource :session, only:[:create, :destroy, :new]

end
