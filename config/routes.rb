CodePron::Application.routes.draw do

  root to: 'static_pages#root'

  namespace :api, defaults: {format: :json} do
    resources :previews, only: [:new, :create, :show, :index, :update]
  end

  resources :htmldocs, only: :show

end
