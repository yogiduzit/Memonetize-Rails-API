Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', {to: 'welcome#index', as: "welcome"}

  resources :users, only: [:new, :create, :destroy]
  resource :sessions, only: [:new, :create, :destroy]
  resources :memes

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :memes
      resources :users
      resource :sessions, only: [:create, :destroy]
      get '/current_user', {to: 'users#current'}
    end
  end
end
