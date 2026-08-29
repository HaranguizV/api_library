Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :book, only: [] do
        collection do
          get    '/all', to: 'book#all'
          get    '/:id', to: 'book#show'
          post   '/',    to: 'book#create'
          put    '/:id', to: 'book#update'
          delete '/:id', to: 'book#delete'
        end
      end
      resources :users do
        collection do
          get '/:id', to: 'users#show'
          post '/', to: 'users#create'
          put '/:id', to: 'users#update'
          delete '/:id', to: 'users#delete'
          patch '/:id', to: 'users#reactivate'
        end
      end
      resources :reviews do
        collection do
          get '/:id', to: 'reviews#show'
          post '/', to: 'reviews#create'
          put '/:id', to: 'reviews#update'
          delete '/:id', to: 'reviews#delete'
          patch '/clean', to: 'reviews#clean'
        end
      end
    end
  end

end
