CodePron::Application.routes.draw do

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :users, only: [:show, :index]

    resources :previews, only: [:create, :show, :index, :update] do
      resources :comments, only: [:index]
    end

    resources :comments, only:[:create, :show]
    resources :follows, only:[:create, :destroy, :show]

  end

  resources :htmldocs, only: :show
  resources :users, only: [:new, :create]
  resource :session, only:[:create, :destroy, :new]

end
