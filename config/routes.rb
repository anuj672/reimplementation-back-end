Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :institutions
      resources :roles
      resources :users do
        get 'institution/:id', on: :collection, action: :institution_users
        get ':id/managed', on: :collection, action: :managed_users
      end
      resources :assignments
      get '/account_requests/pending', controller: :account_requests, action: :pending_requests
      get '/account_requests/processed', controller: :account_requests, action: :processed_requests
      resources :account_requests
      resources :signed_up_teams do
        collection do
          post '/sign_up', to: 'signed_up_teams#sign_up'
          post '/sign_up_student', to: 'signed_up_teams#sign_up_student'
        end
      end
      resources :sign_up_topics do
        collection do
          get :filter
          delete '/', to: 'sign_up_topics#destroy'
        end
      end
    end
  end
end
