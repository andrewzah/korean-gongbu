Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'authentication#login'

      resources :grammar
      post "/grammar/search", to: "grammar#search"
    end
  end
end
