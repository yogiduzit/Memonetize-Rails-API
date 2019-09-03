Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', {to: 'welcome#index', as: "welcome"}
  post '/rails/active_storage/direct_uploads' => 'direct_uploads#create'

  resources :users, only: [:new, :create, :destroy]
  resource :sessions, only: [:new, :create, :destroy]
  resources :memes


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/popular_tags', to: 'memes#get_popular_tags'
      resources :memes do 
        resources :comments, only: [:create, :update, :destroy, :show]
        resources :votes, only: [:create, :update]
      end
      resources :users
      resources :charges, only: [:create]
      resource :sessions, only: [:create, :destroy]

      get '/current_user', {to: 'users#current'}
    end
  end
end
