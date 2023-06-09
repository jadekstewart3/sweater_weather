Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      get "/forecast", to: "forecasts#show"
      post "/users",to: "users#create"
      get "/salaries", to: "salaries#show"
      post "/sessions", to: "users#login"
      post "/road_trip", to: "road_trip#create"
    end
  end
end
